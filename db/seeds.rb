# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = ["Brandon Austin", "Steve Jobs", "Bill Gates", "Elon Musk", "Barack Obama", "Joe Biden", "Donald Trump", "Serena Williams", "Katy Perry", "Adam Sandler"]

users_info = {}

users.each do |name|
    users_info[name] = "#{name.split(" ")[0].downcase}@gmail.com"
end

users_info.each do |full_name, email|
    User.create(:fname => full_name.split(" ")[0], :lname => full_name.split(" ")[1], :email => email, :password => "#{full_name.split(" ")[0]}123")
end

User.all.each do |user|
    user.posts.create(:content => "This is what a post from #{user.name} would look like!")
end

User.all.each_slice(5).to_a[0].each do |user|
    User.all.each_slice(5).to_a[1].each do |friend|
        user.sent_requests.create(:recipient_id => friend.id, :status => true)
    end
end