class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
        respond_to do |format|
            if @comment.save
                format.html { redirect_to request.referrer, notice: "You successfully left a comment" }
            end
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        respond_to do |format|
            format.html { redirect_to request.referrer, notice: "You successfully deleted your comment" }
        end
    end

    def show
        @comment = Comment.find(params[:id])
    end

    private

    def comment_params
       params.require(:comment).permit(:content, :user_id, :post_id)
    end
end