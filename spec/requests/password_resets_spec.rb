require 'spec_helper'

describe "PasswordResets" do
  let(:base_title) { "Eudora" }
  let(:user) { FactoryGirl.create(:user) }
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
				fill_in "Email", 				with:	"Person_1@example.com"
			end
			before { click_button "Send Email" }
			it {should have_content("Email sent with password reset instructions.")  }
		end # end valid submission
	end#end forget page


	
end
