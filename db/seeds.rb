User.create!(name: 'John Doe',
             email: 'originalfirstuser@user.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true,
             activated: true, 
             activated_at: Time.zone.now)

# Generate 99 additional users
99.times do |number|
  name = Faker::Name.name
  email = "example#{number+1}@exampleforapp.com"
  password = 'password'
  User.create!(name: name, email: email, password: password, password_confirmation: password,
               activated: true, activated_at: Time.zone.now)
end

# Generate microposts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Create following relationships.
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
