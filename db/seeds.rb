gabby = User.create!(email: "gabby@example.com", password: "password", password_confirmation: "password", full_name: "Gabitha")
kevin = User.create!(email: "kevin@example.com", password: "password", password_confirmation: "password", full_name: "Kevin Wang")

Category.create!(name: 'Mystery')
Category.create!(name: 'Comedy')
Category.create!(name: 'Reality')

Video.create!(title: 'Monk', description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.', small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category_id: 1)
Video.create!(title: 'Family Guy', description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.', small_cover: '/tmp/family_guy.jpg', large_cover: '', category_id: 2)
Video.create!(title: 'Futurama', description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover: '/tmp/futurama.jpg', large_cover: '', category_id: 2)
Video.create!(title: 'South Park', description: 'Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.', small_cover: '/tmp/south_park.jpg', large_cover: '', category_id: 2)

Video.create!(title: 'Monk2', description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.', small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category_id: 1)
Video.create!(title: 'Family Guy2', description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.', small_cover: '/tmp/family_guy.jpg', large_cover: '', category_id: 2)
Video.create!(title: 'Futurama2', description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover: '/tmp/futurama.jpg', large_cover: '', category_id: 2)
Video.create!(title: 'South Park2', description: 'Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.', small_cover: '/tmp/south_park.jpg', large_cover: '', category_id: 2)

monk = Video.create!(title: 'Monk3', description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.', small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category_id: 1)
Video.create!(title: 'Family Guy3', description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.', small_cover: '/tmp/family_guy.jpg', large_cover: '', category_id: 2)
Video.create!(title: 'Futurama3', description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover: '/tmp/futurama.jpg', large_cover: '', category_id: 2)
Video.create!(title: 'South Park3', description: 'Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.', small_cover: '/tmp/south_park.jpg', large_cover: '', category_id: 2)

Review.create!(user: gabby, video: monk, rating: 3, comment: "Very silly show")
Review.create!(user: gabby, video: monk, rating: 4, comment: "Super loved it")