class User < ApplicationRecord
  has_many :posts
  has_many :sent_requests, foreign_key: "sender_id", class_name: "FriendRequest", :dependent => :destroy
  has_many :received_requests, foreign_key: "recipient_id", class_name: "FriendRequest", :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end