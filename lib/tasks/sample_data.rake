namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_submissions
  end
end

def make_users
  admin = User.create!(username:              "Example User",
                       email:                 "example@puckdrop.org",
                       password:              "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@puckdrop.org"
    password  = "password"
    User.create!(username:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_submissions
  users = User.all(limit: 6)
  50.times do
    title = Faker::Lorem.sentence(5)
    users.each { |user| user.submissions.create!(title: title, link: "www.google.com", goals: 0) }
  end
end