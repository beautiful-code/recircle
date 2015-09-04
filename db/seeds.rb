# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  ['Ravi', 'ravi.bhim@gmail.com'],
  ['SJ', 'sri.cs.nitw@gmail.com'],
  ['NG', 'ngsaip7@gmail.com'],
].each do |user_info|

  User.where(email: user_info.second).first_or_create do |user|
    user.email = user_info.second
    user.name = user_info.first
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end

user1 = User.where(email: 'ravi.bhim@gmail.com').first
user2 = User.where(email: 'sri.cs.nitw@gmail.com').first
user3 = User.where(email: 'ngsaip7@gmail.com').first

# Ravi's books
[
  ['Lean Startup', 'http://ecx.images-amazon.com/images/I/814EXQRrg5L._SL1500_.jpg'],
  ['Siddhartha', 'http://ecx.images-amazon.com/images/I/51OzQMm5ETL._SX368_BO1,204,203,200_.jpg']
].each do |book_info|
  unless user1.books.where(name: book_info.first).first
    user1.books.create(name: book_info.first, image: book_info.second)
  end
end

# SJ's books
[
  ['Charlie Munger', 'http://ecx.images-amazon.com/images/I/41Ma9j8wx%2BL._SX331_BO1,204,203,200_.jpg'],
].each do |book_info|
  unless user1.books.where(name: book_info.first).first
    user2.books.create(name: book_info.first, image: book_info.second)
  end
end


