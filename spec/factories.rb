FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
		sequence(:password_reset_token) { |n| "KAXq4MFi2BdhprxoRxz3c#{n}" }
		password_reset_sent_at 1.hour.ago
    factory :admin do
      admin true
    end
		

  end

	factory :blog do
		sequence(:title) {|n| "Blog #{n}" }
		sequence(:author) {|n| "Author #{n}" }
		body "Seeing the blog"
	end

	factory :listing do
  	title "Lorem ipsum"
  	user
		specific_location "Fallbrook"
		zip_code "90210"
		price 110.95
		details "pretty slick."
		active false
	end
end
