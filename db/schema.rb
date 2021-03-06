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

ActiveRecord::Schema.define(version: 20150924112505) do

  create_table "books", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "image",       default: "http://l7connect.com/wp-content/uploads/2015/06/no-preview.png"
    t.datetime "created_at",                                                                             null: false
    t.datetime "updated_at",                                                                             null: false
    t.string   "state",       default: "unlocked"
    t.integer  "borrower_id"
    t.integer  "condition",   default: 0
  end

  add_index "books", ["user_id"], name: "index_books_on_user_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "events", force: :cascade do |t|
    t.string   "event_type"
    t.text     "event_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "read_status", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "book_id"
    t.string   "type"
  end

  add_index "notifications", ["book_id"], name: "index_notifications_on_book_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "status",       default: 0
    t.integer  "owner_id"
    t.string   "message"
    t.string   "request_type"
  end

  add_index "requests", ["book_id"], name: "index_requests_on_book_id"
  add_index "requests", ["status"], name: "index_requests_on_status"
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
