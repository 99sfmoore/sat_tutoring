class AddCpNameAndEmailToSites < ActiveRecord::Migration
  def change
    add_column :sites, :cp_contact_name, :string
    add_column :sites, :cp_email, :string
  end
end
