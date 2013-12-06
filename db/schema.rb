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

ActiveRecord::Schema.define(version: 20131206175906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "student_id"
    t.string   "answer_choice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "topic"
    t.string   "segment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hw_answers", force: true do |t|
    t.integer  "hw_question_id"
    t.integer  "student_id"
    t.string   "answer_choice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hw_assignments", force: true do |t|
    t.integer  "category_id"
    t.integer  "start_page"
    t.integer  "end_page"
    t.string   "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hw_hints", force: true do |t|
    t.integer  "created_by"
    t.integer  "hw_question_id"
    t.string   "answer_choice"
    t.text     "hint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hw_questions", force: true do |t|
    t.integer  "hw_assignment_id"
    t.integer  "question_num"
    t.string   "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "test_id"
    t.string   "segment"
    t.integer  "section"
    t.integer  "question_num"
    t.string   "category"
    t.string   "difficulty"
    t.string   "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "student_id"
    t.integer  "test_id"
    t.integer  "math"
    t.integer  "reading"
    t.integer  "writing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cp_contact_name"
    t.string   "cp_email"
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "email"
    t.integer  "tutor_id"
    t.string   "high_school"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true, using: :btree

  create_table "tests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "conversion"
  end

  create_table "tutors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "tutors", ["email"], name: "index_tutors_on_email", unique: true, using: :btree
  add_index "tutors", ["remember_token"], name: "index_tutors_on_remember_token", using: :btree

end
