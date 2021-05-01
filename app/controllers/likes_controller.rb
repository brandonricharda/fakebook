class LikesController < ApplicationController
    before_action :authenticate_user!

    def new
        @like = Like.new
    end

    def create
        @like = current_user.likes.build(like_params)
        respond_to do |format|
            if @like.save
                format.html { redirect_to posts_url, notice: "You liked a post" }
            end
        end
    end

    def destroy
        @like = Like.find(params[:id])
        @like.destroy
        respond_to do |format|
            format.html { redirect_to posts_url, notice: "You unliked a post" }
        end
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :post_id)
    end
end