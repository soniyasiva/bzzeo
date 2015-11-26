# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([
  {
    email: "zacharyalevy@gmail.com",
    password: "password",
    password_confirmation: "password"
  }, {
    email: "zach@firstexitmedia.com",
    password: "password",
    password_confirmation: "password"
  }
])

category = Category.create([
  { name: "Software" },
  { name: "Real Estate" },
  { name: "Sales" }
])

post_categories = PostCategory.create([
  { name: "Review" },
  { name: "Job" },
  { name: "Status" },
  { name: "Portfolio" },
  { name: "Promotion" }
])
