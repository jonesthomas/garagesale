require 'spec_helper'

describe "PasswordResets" do
  before(:all) { 10.times { FactoryGirl.create(:user) } }
  after(:all)  { User.delete_all }
  let(:base_title) { "Eudora" }
  subject { page }

	describe "password forget page" do
    before { visit new_password_reset_path }

    it { should have_content('Email Password') }
    it { should have_title(("#{base_title} | Email Password")  ) }

		describe "invalid submission" do
			before { click_button "Send Email" }
			it {should_not have_content("Email sent with password reset instructions.")  }
		end # end invalid submission

		describe "valid submission" do


			before do
				fill_in "Email", 				with:	"person_1@example.com"
				click_button "Send Email" 
			end
	
      it { should have_selector('div.alert.alert-success', text: 'Email sent') }
			it {should have_content("Eudora") }
		end # end valid submission
	end#end forget page


	
end
