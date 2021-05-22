require 'rails_helper'

RSpec.describe FriendRequest, type: :model do

    let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

    let(:friend) { User.create(:fname => "Friend", :lname => "McFriendy", :email => "friend@mcfriendy.com", :password => "bestfriendforever") }

    describe "#create" do

        context "when called without params" do

            let(:request) { FriendRequest.create }

            it "doesn't create record" do
                expect { request }.to_not change { FriendRequest.count }
            end

            it "returns two errors" do
                expect(request.errors.count).to eql 2
            end

            it "returns sender blank error" do
                expect(request.errors[:sender].first).to eql "must exist"
            end

            it "returns recipient blank error" do
                expect(request.errors[:recipient].first).to eql "must exist"
            end

        end

        context "when called with required params" do

            let(:request) { user.sent_requests.create(:recipient_id => friend.id) }

            it "creates record" do
                expect { request }.to change { FriendRequest.count }.by 1
            end

            it "returns zero errors" do
                expect(request.errors.count).to eql 0
            end

        end

    end

    describe ".sender" do

        context "when called on request" do

            let(:request) { user.sent_requests.create(:recipient_id => friend.id) }

            it "returns sender" do
                expect(request.sender).to eql user
            end

        end

    end

    describe ".recipient" do

        context "when called on request" do

            let(:request) { user.sent_requests.create(:recipient_id => friend.id) }

            it "returns recipient" do 
                expect(request.recipient).to eql friend
            end

        end

    end

end
