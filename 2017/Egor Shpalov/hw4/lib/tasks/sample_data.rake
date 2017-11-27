namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    20.times do |n|
      firstname = Faker::Name.first_name
      lastname  = Faker::Name.last_name
      password  = "123456"
      name  = "#{firstname} #{lastname}"
      email = "#{firstname}_#{lastname}_#{n}@bitbonstick.com"
      User.create!(name: name, email: email, password: password,
                   password_confirmation: password)
    end
    users = User.all
    50.times do
      title   = Faker::Lorem.word
      content = Faker::Lorem.sentence(2)
      users.each { |user| user.adverts.create!(title: title, content: content) }
    end
  end
end
