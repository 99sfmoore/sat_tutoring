class RenameCreatedByOnHwHints < ActiveRecord::Migration
  def change
    rename_column :hw_hints, :created_by, :tutor_id
  end
end
