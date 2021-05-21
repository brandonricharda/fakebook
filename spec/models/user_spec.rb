require 'rails_helper'

RSpec.describe User, type: :model do

    describe "#create" do

        context "when called without params" do

            let(:user) { User.create }

            it "doesn't create record" do
                expect { user }.to_not change { User.count }
            end

            it "returns three errors" do
                expect(user.errors.count).to eql 4
            end

            it "returns email blank error" do
                expect(user.errors[:email].first).to eql "can't be blank"
            end

            it "returns password blank error" do
                expect(user.errors[:password].first).to eql "can't be blank"
            end

            it "returns fname blank error" do
                expect(user.errors[:fname].first).to eql "can't be blank"
            end

            it "returns lname blank error" do
                expect(user.errors[:lname].first).to eql "can't be blank"
            end

        end

        context "when called with required params" do

            let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

            it "creates record" do
                expect { user }.to change { User.count }.by 1
            end

        end

    end

    describe ".name" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        it "returns correct name" do
            expect(user.name).to eql "Brandon-Richard Austin"
        end

    end

    describe ".pending_sent_requests" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:friend) { User.create(:fname => "Friend", :lname => "McFriendy", :email => "friend@mcfriendy.com", :password => "bestfriendforever") }

        let!(:request) { user.sent_requests.create(:recipient_id => friend.id) }

        it "returns pending sent request" do
            expect(user.pending_sent_requests.first).to eql request
        end

    end

    describe ".pending_received_requests" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:friend) { User.create(:fname => "Friend", :lname => "McFriendy", :email => "friend@mcfriendy.com", :password => "bestfriendforever") }

        let!(:request) { friend.sent_requests.create(:recipient_id => user.id) }

        it "returns pending received request" do
            expect(user.pending_received_requests.first).to eql request
        end

    end

    describe ".friends" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:friend) { User.create(:fname => "Friend", :lname => "McFriendy", :email => "friend@mcfriendy.com", :password => "bestfriendforever") }

        let!(:request) { friend.sent_requests.create(:recipient_id => user.id, :status => true) }

        it "returns user's friend" do
            expect(user.friends.first).to eql [friend, request]
        end

    end

    describe ".strangers" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let!(:stranger) { User.create(:fname => "Stranger", :lname => "McStrangeFace", :email => "stranger@mcstranger.com", :password => "strangerforever") }

        it "returns unassociated user" do
            expect(user.strangers.first).to eql stranger
        end

    end

    describe ".timeline_posts" do

        let!(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let!(:post) { user.posts.create(:content => "This is a post!") }

        let!(:friend) { User.create(:fname => "Friend", :lname => "McFriendy", :email => "friend@mcfriendy.com", :password => "bestfriendforever") }

        let!(:request) { friend.sent_requests.create(:recipient_id => user.id, :status => true) }

        let!(:friend_post) { friend.posts.create(:content => "This is a friend post!") }

        let!(:stranger) { User.create(:fname => "Stranger", :lname => "McStrangeFace", :email => "stranger@mcstranger.com", :password => "strangerforever") }

        let!(:stranger_post) { stranger.posts.create(:content => "This is a stranger post!") }

        it "returns correct number of posts" do
            expect(user.timeline_posts.count).to eql 2
        end

        it "returns correct posts" do
            expect(user.timeline_posts).to eql [friend_post, post]
        end

        it "ignores stranger post" do
            expect(user.timeline_posts).to_not include stranger_post
        end

    end

    describe ".sorted_timeline_posts" do

        let!(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let!(:post) { user.posts.create(:content => "This is a post!") }

        let!(:friend) { User.create(:fname => "Friend", :lname => "McFriendy", :email => "friend@mcfriendy.com", :password => "bestfriendforever") }

        let!(:request) { friend.sent_requests.create(:recipient_id => user.id, :status => true) }

        let!(:friend_post) { friend.posts.create(:content => "This is a friend post!") }

        it "returns posts in correct order" do
            expect(user.sorted_timeline_posts).to eql [friend_post, post]
        end

    end

    describe ".likes_include?" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:post) { user.posts.create(:content => "This is a post!") }

        let(:unliked_post) { user.posts.create(:content => "This is another post!") }

        let!(:like) { user.likes.create(:post_id => post.id) }

        it "identifies when user's likes include post" do
            expect(user.likes_include?(post)).to eql true
        end

        it "identifies when user's likes exclude post" do
            expect(user.likes_include?(unliked_post)).to eql false
        end

    end

    describe ".find_like" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:post) { user.posts.create(:content => "This is a post!") }

        let!(:like) { user.likes.create(:post_id => post.id) }

        it "returns like record when one exists" do
            expect(user.find_like(post)).to eql [like]
        end

    end

end
