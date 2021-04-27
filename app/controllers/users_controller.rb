class UsersController < ApplicationController
    def index
        @request = FriendRequest.new
    end
end