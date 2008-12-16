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

ActiveRecord::Schema.define(:version => 20081216201634) do

  create_table "complexes", :force => true do |t|
    t.string   "title"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "school_id"
    t.integer  "year"
    t.string   "category"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postal"
    t.string   "mailing_address"
    t.string   "mailing_city"
    t.string   "mailing_province"
    t.string   "mailing_postal"
    t.string   "website"
    t.string   "phone"
    t.string   "fax"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat",              :precision => 20, :scale => 14
    t.decimal  "lng",              :precision => 20, :scale => 14
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "school_id"
    t.integer  "year"
    t.integer  "total"
    t.integer  "kh_enrollment"
    t.integer  "kf_enrollment"
    t.integer  "hs_registration"
    t.integer  "su_enrollment"
    t.integer  "eu_enrollment"
    t.integer  "grade_1"
    t.integer  "grade_2"
    t.integer  "grade_3"
    t.integer  "grade_4"
    t.integer  "grade_5"
    t.integer  "grade_6"
    t.integer  "grade_7"
    t.integer  "grade_8"
    t.integer  "grade_9"
    t.integer  "grade_10"
    t.integer  "grade_11"
    t.integer  "grade_12"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilities", :force => true do |t|
    t.integer  "complex_id"
    t.string   "title"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", :force => true do |t|
    t.string   "name"
    t.integer  "school_id"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :default => 0,  :null => false
    t.string  "server_url"
    t.string  "salt",       :default => "", :null => false
  end

  create_table "schools", :force => true do |t|
    t.integer  "district_id"
    t.string   "code"
    t.string   "name"
    t.string   "category"
    t.string   "funding_group"
    t.string   "school_type"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postal"
    t.string   "mailing_address"
    t.string   "mailing_city"
    t.string   "mailing_province"
    t.string   "mailing_postal"
    t.string   "phone"
    t.string   "fax"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat",              :precision => 20, :scale => 14
    t.decimal  "lng",              :precision => 20, :scale => 14
  end

  create_table "stores", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "title"
    t.string   "street_address"
    t.string   "locality"
    t.string   "region"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "country"
    t.string   "url"
    t.string   "map_url"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_url"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "repair"
    t.boolean  "sellappletvs"
    t.boolean  "sellipods"
    t.boolean  "selliphones"
    t.boolean  "applestore"
    t.boolean  "sellmacs"
    t.string   "concierge"
    t.decimal  "lat",            :precision => 20, :scale => 14
    t.decimal  "lng",            :precision => 20, :scale => 14
    t.date     "date_open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "identity_url"
  end

end
