namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

		35.times do |n|
			title = "Blog #{n}"
			author = "Author #{n}"
			body = "	The test in Listing 10.6 of the has_many association doesn’t test for much—it merely verifies the existence of a microposts attribute. In this section, we’ll add ordering and dependency to microposts, while also testing that the user.microposts method actually returns an array of microposts.

	We will need to construct some microposts in the User model test, which means that we should make a micropost factory at this point. To do this, we need a way to make an association in Factory Girl. Happily, this is easy, as seen in Listing 10.9."
			Blog.create!(title: title, author: author, body: body)
		end
  end
end
