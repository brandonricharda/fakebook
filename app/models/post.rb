class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, :dependent => :destroy

    def author
        User.find(self.user_id).name
    end
end