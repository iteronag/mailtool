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

ActiveRecord::Schema.define(:version => 20161211130732) do

  create_table "email_templates", :force => true do |t|
    t.string   "language"
    t.integer  "version",       :default => 0
    t.integer  "group_id"
    t.boolean  "status"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.text     "new_text"
    t.text     "reminder_text"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "mail_id_definitions", :force => true do |t|
    t.string   "from"
    t.string   "cc"
    t.string   "bcc"
    t.integer  "ageing_reminder", :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "group_id"
    t.string   "subject"
  end

  create_table "opportunity_generators", :force => true do |t|
    t.string   "company"
    t.string   "website"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mail_id"
    t.boolean  "mail_id_status"
    t.boolean  "is_hr_or_info"
    t.string   "generated_mail_id1"
    t.boolean  "generated_mail_id1_status"
    t.string   "generated_mail_id2"
    t.boolean  "generated_mail_id2_status"
    t.string   "phone_number"
    t.string   "technology"
    t.string   "job_title"
    t.string   "job_requirements"
    t.string   "job_url"
    t.string   "linkedin_url"
    t.date     "generated_date"
    t.string   "status"
    t.string   "language"
    t.integer  "group_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "uploads", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
  end

end
