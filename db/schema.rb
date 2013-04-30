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

ActiveRecord::Schema.define(:version => 20130430023324) do

  create_table "admins", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guestcounts", :force => true do |t|
    t.integer  "count",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "name"
    t.text     "content",    :limit => 255
    t.boolean  "frontshow"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "newsphotos", :force => true do |t|
    t.string   "image"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "news_id"
  end

  create_table "orderitems", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "totalprice"
    t.string   "order_name"
    t.string   "order_phone"
    t.string   "order_companytaxID"
    t.string   "order_email"
    t.string   "receive_name"
    t.string   "receive_phone"
    t.string   "receive_address"
    t.date     "receive_date"
    t.string   "receive_time"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "isAdminCheck"
    t.string   "order_fax"
    t.integer  "shippingfee"
    t.text     "note"
  end

  create_table "products", :force => true do |t|
    t.string   "image"
    t.string   "name"
    t.integer  "price"
    t.string   "weight"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "addDate"
    t.boolean  "frontshow"
    t.boolean  "admindelete"
    t.string   "producttype"
    t.text     "description"
    t.integer  "ordernum"
  end

end
