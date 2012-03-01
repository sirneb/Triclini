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

ActiveRecord::Schema.define(:version => 20120229205021) do

  create_table "club_members", :force => true do |t|
    t.integer  "user_id"
    t.string   "membershipID"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address"
    t.integer  "club_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "subdomain"
  end

  create_table "employees", :force => true do |t|
    t.integer  "user_id"
    t.integer  "club_id"
    t.string   "companyID"
    t.string   "job_position"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "contact_number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "hall_id"
    t.string   "name"
    t.date     "date"
    t.text     "description"
    t.integer  "capacity"
    t.boolean  "reservable"
    t.integer  "max_party_size"
    t.integer  "start_reservable"
    t.integer  "stop_reservable"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "halls", :force => true do |t|
    t.integer  "club_id"
    t.string   "name"
    t.integer  "total_capacity"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "description"
    t.boolean  "active"
  end

  create_table "normal_dinings", :force => true do |t|
    t.integer  "hall_id"
    t.integer  "capacity"
    t.text     "default_operation_hours"
    t.boolean  "reservable"
    t.integer  "start_reservable"
    t.integer  "stop_reservable"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "hall_id"
    t.boolean  "isEvent"
    t.integer  "number_of_guests"
    t.text     "note"
    t.date     "date"
    t.time     "time"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "statuses", :force => true do |t|
    t.integer  "reservation_id"
    t.integer  "user_modifier_id"
    t.string   "state"
    t.text     "reason"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "temporary_changes", :force => true do |t|
    t.integer  "normal_dining_id"
    t.date     "date"
    t.text     "changed_operation_hours"
    t.integer  "changed_capacity"
    t.boolean  "changed_reservable"
    t.text     "reason"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
