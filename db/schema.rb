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

ActiveRecord::Schema.define(version: 20140127010411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "student_id"
    t.string   "answer_choice"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "second_try"
  end

  add_index "answers", ["question_id", "student_id"], name: "index_answers_on_question_id_and_student_id", unique: true, using: :btree

  create_table "assignments", force: true do |t|
    t.integer  "student_id"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "homework_id"
  end

  create_table "assignments_hw_hints", force: true do |t|
    t.integer "assignment_id"
    t.integer "hw_hint_id"
  end

  add_index "assignments_hw_hints", ["assignment_id", "hw_hint_id"], name: "index_assignments_hw_hints_on_assignment_id_and_hw_hint_id", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_meetings", force: true do |t|
    t.integer  "session_number"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
  end

  create_table "homeworks", force: true do |t|
    t.integer "lesson_plan_id"
    t.integer "segment_id"
  end

  create_table "homeworks_sections", force: true do |t|
    t.integer "section_id"
    t.integer "homework_id"
  end

  create_table "hw_hints", force: true do |t|
    t.integer  "tutor_id"
    t.integer  "question_id"
    t.string   "answer_choice"
    t.text     "hint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_plans", force: true do |t|
    t.integer  "tutor_id"
    t.integer  "group_meeting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.text     "post_notes"
    t.text     "other_hw"
  end

  create_table "lesson_plans_sections", force: true do |t|
    t.integer "lesson_plan_id"
    t.integer "section_id"
  end

  create_table "questions", force: true do |t|
    t.integer  "question_num"
    t.string   "category_string"
    t.string   "difficulty"
    t.string   "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
    t.integer  "category_id"
    t.integer  "difficulty_num"
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

  add_index "scores", ["test_id", "student_id"], name: "index_scores_on_test_id_and_student_id", using: :btree

  create_table "sections", force: true do |t|
    t.integer  "start_page"
    t.integer  "end_page"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_num"
    t.integer  "test_id"
    t.integer  "segment_id"
    t.boolean  "assignable"
    t.integer  "topic_id"
  end

  create_table "segments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cp_contact_name"
    t.string   "cp_email"
    t.integer  "team_leader_id"
    t.string   "leader_email"
    t.string   "cp_nickname"
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
    t.boolean  "assignable"
  end

  create_table "topics", force: true do |t|
    t.integer  "number"
    t.string   "name"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "admin"
    t.boolean  "leader"
    t.string   "email_for_students"
  end

  add_index "tutors", ["email"], name: "index_tutors_on_email", unique: true, using: :btree
  add_index "tutors", ["remember_token"], name: "index_tutors_on_remember_token", using: :btree

end
