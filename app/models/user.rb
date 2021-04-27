class User < ApplicationRecord
  has_many :posts
  has_many :sent_requests, foreign_key: "sender_id", class_name: "FriendRequest", :dependent => :destroy
  has_many :received_requests, foreign_key: "recipient_id", class_name: "FriendRequest", :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def name 
    "#{fname} #{lname}"
  end

  def pending_sent_requests
    self.sent_requests.select { |request| request.status == false }
  end

  def pending_received_requests
    self.received_requests.select { |request| request.status == false }
  end

  def friends
    result = {}
    accepted_sent_requests = self.sent_requests.select { |request| request.status == true }
    accepted_received_requests = self.received_requests.select { |request| request.status == true }
    accepted_sent_requests.each { |request| result[request.recipient.name] = request }
    accepted_received_requests.each { |request| result[request.sender.name] = request }
    result
  end

  def strangers
    sent_request_names = self.sent_requests.map { |request| request.recipient.name }
    received_request_names = self.received_requests.map { |request| request.sender.name }
    User.all.select { |user| !sent_request_names.include?(user.name) && !received_request_names.include?(user.name) }.select { |user| user != self }
  end
end