class FriendRequestsController < ApplicationController
    before_action :authenticate_user!

    def index
        @requests = current_user.received_requests
    end

    def new
        @request = FriendRequest.new
    end

    def create
        @request = current_user.sent_requests.build(friend_request_params)
        respond_to do |format|
            if @request.save
                format.html { redirect_to users_url, notice: "Friend request successfully sent." }
            end
        end
    end

    def destroy
        @request = FriendRequest.find(params[:id])
        @request.destroy
        respond_to do |format|
            format.html { redirect_to users_url, notice: "Friend request successfully cancelled." }
        end
    end

    def update
        @request = FriendRequest.find(params[:id])
        @request.update(status: params[:status])
        respond_to do |format|
            format.html { redirect_to users_url, notice: "Friend request successfully accepted." }
        end
    end

    private

    def friend_request_params
        params.require(:friend_request).permit(:sender_id, :recipient_id, :status)
    end
end