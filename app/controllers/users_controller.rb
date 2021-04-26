class UsersController < ApplicationController
    def index
        # Need some logic in here that distinguishes between friends/request recipients and users with no relation
        @users = User.all
        @request = FriendRequest.new
    end
end