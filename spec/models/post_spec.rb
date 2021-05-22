require 'rails_helper'

RSpec.describe Post, type: :model do

    describe "#create" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        context "when called with no params" do

            let(:post) { Post.create }

            it "doesn't create record" do
                expect { post }.to_not change { Post.count }
            end

            it "returns two errors" do
                expect(post.errors.count).to eql 2
            end

            it "returns content blank error" do
                expect(post.errors[:content].first).to eql "can't be blank"
            end

            it "returns user blank error" do
                expect(post.errors[:user].first).to eql "must exist"
            end

        end

        context "when called with required params" do

            let(:post) { user.posts.create(:content => "This is a post") }

            it "creates a record" do
                expect { post }.to change { Post.count }.by 1
            end

            it "returns zero errors" do
                expect(post.errors.count).to eql 0
            end

        end

    end

    describe ".author" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:post) { user.posts.create(:content => "This is a post") }

        context "when called on post" do
            it "returns author" do
                expect(post.author).to eql user
            end
        end

    end

    describe ".liked_users" do

        let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

        let(:post) { user.posts.create(:content => "This is a post") }

        let(:admirer) { User.create(:fname => "Steve", :lname => "Jobs", :email => "timappleseed@gmail.com", :password => "nowindowsallowed") }

        let!(:like) { post.likes.create(:user_id => admirer.id) }

        context "when called on a post" do

            it "returns array" do
                expect(post.liked_users.class).to eql Array
            end

            it "returns array with string names" do
                expect(post.liked_users.first.class).to eql String 
            end

            it "returns correct name" do
                expect(post.liked_users.first).to eql "Steve Jobs"
            end

        end

    end

end
