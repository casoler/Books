# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100924002324) do

  create_table "books", :force => true do |t|
    t.string   "title",                      :default => "", :null => false
    t.string   "author_last",  :limit => 25, :default => "", :null => false
    t.string   "author_first", :limit => 25, :default => "", :null => false
    t.integer  "publish_year",               :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",                                :null => false
  end

  create_table "books_users", :id => false, :force => true do |t|
    t.integer "book_id"
    t.integer "user_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",   :limit => 25, :default => "", :null => false
    t.string   "password",   :limit => 25, :default => "", :null => false
    t.string   "first_name", :limit => 25, :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
