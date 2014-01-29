class AddAbbreviationToSite < ActiveRecord::Migration
  def change
    add_column :sites, :abbreviation, :string
  end
end
