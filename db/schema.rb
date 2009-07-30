# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 9) do

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.integer  "parent_id"
    t.string   "navlabel"
    t.integer  "position"
  end

  create_table "passengers", :force => true do |t|
    t.string    "name",               :limit => 40, :default => "", :null => false
    t.string    "contact_number",     :limit => 10, :default => "", :null => false
    t.string    "suburb_origin",      :limit => 40, :default => "", :null => false
    t.string    "street",             :limit => 30, :default => "", :null => false
    t.string    "street_number",      :limit => 10, :default => "", :null => false
    t.string    "building",           :limit => 10, :default => "", :null => false
    t.string    "suburb_destination", :limit => 40, :default => "", :null => false
    t.integer   "passenger_number",   :limit => 3
    t.string    "taxi_type",          :limit => 15, :default => "", :null => false
    t.datetime  "date",                                             :null => false
    t.time      "time_required",                                    :null => false
    t.timestamp "created_on",                                       :null => false
    t.timestamp "updated_on",                                       :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authorization_token"
  end

end
