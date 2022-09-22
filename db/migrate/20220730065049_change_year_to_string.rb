class ChangeYearToString < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :year 
    add_column :users, :year, :string
  end
end
