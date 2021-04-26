class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.references :sender
      t.references :recipient
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
