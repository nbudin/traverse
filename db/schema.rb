# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111104162849) do

  create_table "moves", :force => true do |t|
    t.integer  "from_node_id", :null => false
    t.integer  "to_node_id",   :null => false
    t.text     "name"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counters", :force => true do |t|
    t.integer  "game_id",       :null => false
    t.integer  "start_node_id"
    t.string   "name",          :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "effects", :force => true do |t|
    t.integer  "trigger_id", :null => false
    t.integer  "counter_id", :null => false
    t.integer  "result_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", :force => true do |t|
    t.integer  "game_id",     :null => false
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "play_counters", :force => true do |t|
    t.integer  "counter_id",      :null => false
    t.integer  "playthrough_id",  :null => false
    t.integer  "current_node_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playthroughs", :force => true do |t|
    t.string   "name"
    t.integer  "game_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requirements", :force => true do |t|
    t.integer  "counter_id",    :null => false
    t.integer  "move_id", :null => false
    t.integer  "node_id",       :null => false
    t.text     "explanation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turns", :force => true do |t|
    t.integer  "playthrough_id",  :null => false
    t.integer  "move_id",   :null => false
    t.integer  "play_counter_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
