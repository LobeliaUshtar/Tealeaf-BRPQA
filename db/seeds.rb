# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!([
  {
    email: "gabby@example.com",
    password: "password",
    password_confirmation: "password",
    full_name: "Gabitha"
  }
])

mystery = Category.create(name: 'Mystery')
comedy = Category.create(name: 'Comedy')

Video.create!(title: 'Monk', description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.', small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category_id: mystery)
Video.create!(title: 'Family Guy', description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.', small_cover: '/tmp/family_guy.jpg', large_cover: '', category_id: comedy)
Video.create!(title: 'Futurama', description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover: '/tmp/futurama.jpg', large_cover: '', category_id: comedy)
Video.create!(title: 'South Park', description: 'Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.', small_cover: '/tmp/south_park.jpg', large_cover: '', category_id: comedy)