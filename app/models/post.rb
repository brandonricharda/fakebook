class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, :dependent => :destroy
    has_many :comments, :dependent => :destroy

    def author
        User.find(self.user_id)
    end

    def liked_users
        self.likes.map { |like| like.user.name }
    end
end