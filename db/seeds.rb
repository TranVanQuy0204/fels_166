User.create!(name: "TrangVu",
  email: "trangvuuet@gmail.com",
  password: "Trang1912",
  password_confirmation: "Trang1912",
  admin: true)
99.times do |n|
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
10.times do |n|
  name  = Faker::Name.name
  Category.create! name: name
end
Word.create! content:"Xin chao"
50.times do |n|
  name  = Faker::Name.name
  Word.create!(content: name,
    category_id: 1)
end
