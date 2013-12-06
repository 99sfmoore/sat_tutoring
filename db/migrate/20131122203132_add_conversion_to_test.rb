class AddConversionToTest < ActiveRecord::Migration
  def change
    add_column :tests, :conversion, :text
  end
end
