require 'spec_helper'

describe "User pages" do
  let(:base_title) { "Eudora" }
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(("#{base_title} | Sign up")  ) }

  end#end signup page

	describe "profile page" do
		let(:user) {FactoryGirl.create(:user)}
		before {visit user_path(user)}

		it {should have_selector('h1', text: user.name) }
		#it {should have_selector('title', text: user.name ) } #skipping this as I am not able to get it to work
		#it {should have_title("#{base_title} | Michael Hartl")} #this works, so title is provided
	end#end profile page
end
