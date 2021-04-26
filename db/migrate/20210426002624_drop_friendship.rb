class DropFriendship < ActiveRecord::Migration[6.1]
  def change
    drop_table :friendships
  end
end
