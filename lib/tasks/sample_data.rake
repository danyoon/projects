namespace :db do
  desc "Fill database with sample data"
  #task populate: :environment do
    #make_users
    #make_microposts
    #make_relationships
  #end

  task import: :environment do
    make_hotels
  end
end

def make_hotels
  require 'csv'
  file = "db/hotels.csv"
  CSV.foreach(file, :headers => true) do |row|
    Hotel.create!({ 
    :name => row[2],
    :address => row[3],
    :city => row[4],
    :country => row[5],
    :zipcode => row[6],
    :mainstreet => row[7],
    :crossstreet => row[8],
    :key => row[9],
    :owner => row[10],
    :image => row[11]
    })
    #Hotel.create!(row.to_hash)
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end
