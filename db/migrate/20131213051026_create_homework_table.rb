class CreateHomeworkTable < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :lesson_plan_id
    end

    create_table :book_sections_homeworks do |t|
      t.belongs_to :book_section_id
      t.belongs_to :homework_id
    end
  end
end
