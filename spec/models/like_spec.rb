require 'rails_helper'

RSpec.describe Like, type: :model do

    describe "#create" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:post) { user.posts.create(:content => "This is a post") }

        context "when called without params" do

            let(:like) { Like.create }
            
            it "doesn't create record" do
                expect { like }.to_not change { Like.count }
            end

            it "returns two errors" do
                expect(like.errors.count).to eql 2
            end

            it "returns user missing error" do
                expect(like.errors[:user].first).to eql "must exist"
            end

            it "returns post missing error" do
                expect(like.errors[:post].first).to eql "must exist"
            end

        end

        context "when called with required params" do

            let(:like) { post.likes.create(:user_id => user.id) }

            it "creates record" do
                expect { like }.to change { Like.count }.by 1
            end

            it "returns zero errors" do
                expect(like.errors.count).to eql 0
            end

        end

        context "when duplication attempted" do

            let!(:like) { post.likes.create(:user_id => user.id) }

            let(:duplicate_like) { post.likes.create(:user_id => user.id) }

            it "doesn't create record" do
                expect { duplicate_like }.to_not change { Like.count }
            end

        end

    end

    describe ".post" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:post) { user.posts.create(:content => "This is a post") }

        let(:like) { post.likes.create(:user_id => user.id) }

        context "when called on like" do
            it "returns associated post" do
                expect(like.post).to eql post
            end
        end

    end

    describe ".user" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:post) { user.posts.create(:content => "This is a post") }

        let(:like) { post.likes.create(:user_id => user.id) }

        context "when called on like" do
            it "returns associated user" do
                expect(like.user).to eql user
            end
        end

    end

end
