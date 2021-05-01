class PostsController < ApplicationController
    before_action :authenticate_user!

    def new
        @post = Post.new
    end

    def index
        @posts = Post.all
        @like = Like.new
        @comment = Comment.new
    end

    def create
        @post = current_user.posts.build(post_params)
        respond_to do |format|
            if @post.save
                format.html { redirect_to request.referrer, notice: "Post successfully created" }
            else
                format.html { redirect_to request.referrer, notice: "There was an error creating your post. Please try again." }
            end
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        respond_to do |format|
            format.html { redirect_to request.referrer, notice: "You deleted a post" }
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    private

    def post_params
        params.permit(:content)
    end

end