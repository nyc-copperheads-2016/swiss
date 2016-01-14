# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create!(username: Faker::Internet.user_name, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password)

b = Bookmark.create!(url: "http://www.oracle.com/technetwork/java/javase/downloads/index.html")

c = Category.create!(name: Faker::Hipster.word)

ub = b.user_bookmarks.create!(name: Faker::Hipster.word, user: u)

ubc = UserBookmarkCategory.create!(category: c, user_bookmark: ub)


# id: nil, user_bookmark_id: nil, category_id: nil,




# ubc = ub.user_bookmark_categories.create!(category: c)



