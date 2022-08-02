class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.belongs_to :friend_1, class_name: "User"
      t.belongs_to :friend_2, class_name: "User"
      t.timestamps
    end
  end
end
