10.times do
  Tag.create(name: Faker::GameOfThrones.house)
end
puts Cowsay.say("Generated up to 10 tags", 'random')

password = "password"
20.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password_digest: User.new(:password => password).password_digest)
end

tags = Tag.all
users = User.all
200.times do
  user = users.sample
  question = Question.create(title: Faker::Company.catch_phrase,
                   body:  Faker::Hacker.say_something_smart,
                   user: user,
                   tags:  tags.sample(rand(3) + 1),
                   view_count: rand(1000))
  rand(5).times do
    Answer.create(question: question,
                  body:     Faker::Hacker.say_something_smart,
                  user: users.sample)
  end
  rand(5).times do
    Vote.create(question: question,
                user: User.where("id != #{user.id}").sample,
                is_up: [true, false].sample)
  end
end
puts Cowsay.say("SEEDS!", 'random')
