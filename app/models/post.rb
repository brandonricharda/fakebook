class Post < ApplicationRecord
    belongs_to :user

    def author
        User.find(self.user_id).name
    end
end