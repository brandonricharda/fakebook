require 'rails_helper'

RSpec.describe Comment, type: :model do

    let(:user) { User.create(:fname => ENV["first_name"], :lname => ENV["last_name"], :email => ENV["valid_email"], :password => ENV["password"]) }

    let(:post) { user.posts.create(:content => "This is a post") }

    describe "create" do

        context "when called without params" do

            let(:comment) { Comment.create }

            it "doesn't create record" do
                expect { comment }.to_not change { Comment.count }
            end

            it "returns three errors" do
                expect(comment.errors.count).to eql 3
            end

            it "returns content blank error" do
                expect(comment.errors[:content].first).to eql "can't be blank"
            end

            it "returns user missing error" do
                expect(comment.errors[:user].first).to eql "must exist"
            end

            it "returns post missing error" do
                expect(comment.errors[:post].first).to eql "must exist"
            end

        end

        context "when called with required params" do

            let(:comment) { post.comments.create(:user_id => user.id, :content => "This is a comment") }
    
            it "creates record" do
                expect { comment }.to change { Comment.count }.by 1
            end
    
            it "returns zero errors" do
                expect(comment.errors.count).to eql 0
            end
    
        end

    end

    describe ".user" do

        let(:comment) { post.comments.create(:user_id => user.id, :content => "This is a comment") }

        context "when called on comment" do
            it "returns owner" do
                expect(comment.user).to eql user
            end    
        end

    end

    describe ".post" do

        let(:comment) { post.comments.create(:user_id => user.id, :content => "This is a comment") }

        context "when called on comment" do
            it "returns post" do
                expect(comment.post).to eql post
            end
        end

    end

end
