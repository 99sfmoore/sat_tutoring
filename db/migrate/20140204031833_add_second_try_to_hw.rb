class AddSecondTryToHw < ActiveRecord::Migration
  def change
    add_column :homeworks, :second_try, :boolean
  end
end
