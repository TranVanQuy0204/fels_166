User.create!(name: "TrangVu",
  email: "trangvuuet@gmail.com",
  password: "Trang1912",
  password_confirmation: "Trang1912",
  admin: true)
10.times do |n|
  name  = Faker::Name.name + "djdhd"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow followed}
followers.each {|follower| follower.follow user}
Category.create! name:"English"
5.times do |n|
  name  = Faker::Name.name
  Category.create! name: name
end
