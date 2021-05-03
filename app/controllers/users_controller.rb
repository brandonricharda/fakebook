class UsersController < ApplicationController
    def index
        @request = FriendRequest.new
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        @like = Like.new
        @post = Post.new
        @comment = Comment.new
    end

    def edit
        @user = current_user
    end
end