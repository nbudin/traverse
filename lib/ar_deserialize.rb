# Modified from http://eigenjoy.com/2008/08/11/activerecord-from_xml-and-from_json-part-2/

module ActiveRecord
  class Base
  
    def self.from_hash( hash )
      built_objects = {}
      delayed_associations = {}
      
      instance = from_hash_first_pass(hash, built_objects, delayed_associations)
      
      delayed_associations.each do |delayed_instance, associations|
        associations.each do |association_name, (class_name, instance_id)|
          delayed_instance.send("#{association_name}=",
             built_objects[class_name][instance_id.to_s])
        end
      end
      
      instance
    end
 
    def self.from_json( json )
      from_hash safe_json_decode( json )
    end
 
    # The xml has a surrounding class tag (e.g. ship-to),
    # but the hash has no counterpart (e.g. 'ship_to' => {} )
    def self.from_xml( xml )
      from_hash begin
        Hash.from_xml(xml)[to_s.demodulize.underscore]
      rescue ; {} end
    end
    
    private
    # JSON.decode, or return {} if anything goes wrong.
    def self.safe_json_decode( json )
      return {} if !json
      begin
        ActiveSupport::JSON.decode json
      rescue ; {} end
    end
    
    def self.from_hash_first_pass( hash, built_objects, delayed_associations )    
      belongs_to_associations = reflect_on_all_associations.select do |reflection|
        reflection.association_class <= ActiveRecord::Associations::BelongsToAssociation
      end
      
      belongs_to_column_reflections = belongs_to_associations.inject({}) do |result, reflection|
        result[reflection.foreign_key] = reflection
        result
      end
       
      h = hash.dup
      instance_id = h.delete("id")

      delayed_association_values = {}
      
      h.each do |key,value|
        if belongs_to_column_reflections[key]
          # delay building it until later
          reflection = belongs_to_column_reflections[key]
          delayed_association_values[reflection.name] = [reflection.klass.name, h.delete(key)]
        end
      
        case value
        when Array
          h[key].map! { |e| reflect_on_association(
             key.to_sym ).klass.from_hash_first_pass(e, built_objects, delayed_associations) }
        when Hash
          h[key] = reflect_on_association(
             key.to_sym ).klass.from_hash_first_pass(value, built_objects, delayed_associations)
        end
      end
      
      instance = new h
      
      built_objects[self.name] ||= {}
      built_objects[self.name][instance_id.to_s] = instance
      
      delayed_associations[instance] = delayed_association_values
      
      instance
    end
  end # class Base
end # module ActiveRecord
