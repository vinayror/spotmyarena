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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151008205821) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "avg",           limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "booking_dates", force: :cascade do |t|
    t.date     "date_of_booking"
    t.boolean  "status",          limit: 1
    t.integer  "ground_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "booking_dates", ["ground_id"], name: "index_booking_dates_on_ground_id", using: :btree

  create_table "booking_times", force: :cascade do |t|
    t.boolean  "status",             limit: 1
    t.integer  "booking_date_id",    limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "booking_id",         limit: 4
    t.integer  "timeslot_id",        limit: 4
    t.boolean  "booked",             limit: 1,   default: false
    t.integer  "person",             limit: 4
    t.string   "slot",               limit: 255
    t.integer  "person_id",          limit: 4
    t.float    "slot_price",         limit: 24
    t.string   "cancelation_status", limit: 255
  end

  add_index "booking_times", ["booking_date_id"], name: "index_booking_times_on_booking_date_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.boolean  "cancel",     limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "cancel_bookings", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "ground_id",        limit: 4
    t.integer  "booking_time_id",  limit: 4
    t.text     "description",      limit: 65535
    t.boolean  "approved",         limit: 1
    t.boolean  "discard",          limit: 1
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "response_message", limit: 65535
  end

  create_table "commontator_comments", force: :cascade do |t|
    t.string   "creator_type",      limit: 255
    t.integer  "creator_id",        limit: 4
    t.string   "editor_type",       limit: 255
    t.integer  "editor_id",         limit: 4
    t.integer  "thread_id",         limit: 4,                 null: false
    t.text     "body",              limit: 65535,             null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   limit: 4,     default: 0
    t.integer  "cached_votes_down", limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at", using: :btree

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.string   "subscriber_type", limit: 255, null: false
    t.integer  "subscriber_id",   limit: 4,   null: false
    t.integer  "thread_id",       limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: :cascade do |t|
    t.string   "commontable_type", limit: 255
    t.integer  "commontable_id",   limit: 4
    t.datetime "closed_at"
    t.string   "closer_type",      limit: 255
    t.integer  "closer_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true, using: :btree

  create_table "ground_attachments", force: :cascade do |t|
    t.integer  "ground_id",  limit: 4
    t.string   "photo",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "grounds", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "city",              limit: 255
    t.text     "area",              limit: 65535
    t.string   "pincode",           limit: 255
    t.text     "address",           limit: 65535
    t.string   "category",          limit: 255
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "status",            limit: 1
    t.boolean  "publish",           limit: 1,     default: false
    t.float    "weekend_price",     limit: 24
    t.float    "weekday_price",     limit: 24
    t.string   "phone",             limit: 255
    t.integer  "court",             limit: 4
    t.text     "attention_message", limit: 65535
    t.string   "merchant_id",       limit: 255
  end

  add_index "grounds", ["user_id"], name: "index_grounds_on_user_id", using: :btree

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "overall_avg",   limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "stars",         limit: 24,  null: false
    t.string   "dimension",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id",   limit: 4
    t.string   "cacheable_type", limit: 255
    t.float    "avg",            limit: 24,  null: false
    t.integer  "qty",            limit: 4,   null: false
    t.string   "dimension",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "timeslots", force: :cascade do |t|
    t.string   "slot",       limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "booked",     limit: 1,   default: false
    t.string   "person",     limit: 255
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "status",         limit: 255
    t.string   "transaction_id", limit: 255
    t.string   "amount_debit",   limit: 255
    t.string   "bank_ref_num",   limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "mobile",                 limit: 255
    t.integer  "age",                    limit: 4
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "city",                   limit: 255
    t.string   "address",                limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "oauth_token",            limit: 255
    t.datetime "oauth_expires_at"
    t.string   "confirmation_token",     limit: 255
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "avatar",                 limit: 255
    t.string   "member_id",              limit: 255
    t.string   "role",                   limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "booking_dates", "grounds"
  add_foreign_key "booking_times", "booking_dates"
  add_foreign_key "bookings", "users"
  add_foreign_key "grounds", "users"
end
