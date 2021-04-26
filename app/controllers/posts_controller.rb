class PostsController < ApplicationController
    before_action :authenticate_user!

    def new
        @post = Post.new
    end

    def index
        @posts = Post.all
    end

    def create
        @post = current_user.posts.build(post_params)
        respond_to do |format|
            if @post.save
                format.html { redirect_to @post, notice: "Post successfully created" }
            else
                format.html { render :new, notice: "There was an error creating your post. Please try again." }
            end
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    private

    def post_params
        params.require(:post).permit(:content)
    end

end