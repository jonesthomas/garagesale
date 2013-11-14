FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

	factory :blog do
		sequence(:title) {|n| "Blog #{n}" }
		sequence(:author) {|n| "Author #{n}" }
		body "	The test in Listing 10.6 of the has_many association doesn’t test for much—it merely verifies the existence of a microposts attribute. In this section, we’ll add ordering and dependency to microposts, while also testing that the user.microposts method actually returns an array of microposts.

	We will need to construct some microposts in the User model test, which means that we should make a micropost factory at this point. To do this, we need a way to make an association in Factory Girl. Happily, this is easy, as seen in Listing 10.9."
	end
end
