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
		it {should have_title("#{base_title} | #{user.name}")} #this was the compromise to get it to work
	end#end profile page

	describe "signup" do
		before { visit signup_path }
		let (:submit) {"Create my account"}
		
		describe "with invalid information" do
			it "should not create a user" do
				expect {click_button submit }.not_to change(User, :count)
			end #not create a user

			describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end #end after submission
		end #with invalid information
		
		describe "with valid information" do
			before do
				fill_in "Name", 				with: "Example User"
				fill_in "Email", 				with:	"user@example.com"
				fill_in "Password", 		with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end 
			it "should create a user" do
				expect {click_button submit}.to change(User, :count).by(1)
			end

			 describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

				it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end #end after saving the user		
		end #with valid information
		
	end #end signup

end
