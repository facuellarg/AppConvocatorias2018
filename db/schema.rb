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

ActiveRecord::Schema.define(version: 20180420015221) do

  create_table "activities", force: :cascade do |t|
    t.integer "convocation_id"
    t.string "description"
    t.index ["convocation_id"], name: "index_activities_on_convocation_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "permits"
    t.integer "phone_ext"
    t.integer "dependence_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["dependence_id"], name: "index_admins_on_dependence_id"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "application_documents", force: :cascade do |t|
    t.integer "application_id"
    t.integer "user_document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_documents_on_application_id"
    t.index ["user_document_id"], name: "index_application_documents_on_user_document_id"
  end

  create_table "applications", force: :cascade do |t|
    t.integer "student_id"
    t.integer "convocation_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["convocation_id"], name: "index_applications_on_convocation_id"
    t.index ["student_id"], name: "index_applications_on_student_id"
  end

  create_table "convocation_dependences", force: :cascade do |t|
    t.integer "convocation_id"
    t.integer "dependence_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["convocation_id"], name: "index_convocation_dependences_on_convocation_id"
    t.index ["dependence_id"], name: "index_convocation_dependences_on_dependence_id"
  end

  create_table "convocations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "level"
    t.date "end_date"
    t.integer "admin_id"
    t.integer "vacants"
    t.integer "hours_per_week"
    t.float "payout"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_convocations_on_admin_id"
  end

  create_table "dependences", force: :cascade do |t|
    t.string "name"
  end

  create_table "documents", force: :cascade do |t|
    t.string "address"
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "description"
    t.integer "convocation_id"
    t.index ["convocation_id"], name: "index_profiles_on_convocation_id"
  end

  create_table "required_files", force: :cascade do |t|
    t.string "name"
    t.integer "convocation_id"
    t.index ["convocation_id"], name: "index_required_files_on_convocation_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.integer "convocation_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["convocation_id"], name: "index_requirements_on_convocation_id"
  end

  create_table "user_documents", force: :cascade do |t|
    t.integer "user_id"
    t.integer "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_user_documents_on_document_id"
    t.index ["user_id"], name: "index_user_documents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "dependence_id"
    t.index ["dependence_id"], name: "index_users_on_dependence_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
