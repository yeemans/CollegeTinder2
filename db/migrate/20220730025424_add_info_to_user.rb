class AddInfoToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :college, :string
    add_column :users, :year, :integer
    add_column :users, :major, :string
  end
end
