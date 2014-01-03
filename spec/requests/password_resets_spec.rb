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



		describe "valid submission" do
			before do
				fill_in "Email", 				with:	"person_1@example.com"
				click_button "Send Email" 
			end
	
      it { should have_selector('div.alert.alert-success', text: 'Email sent') }
			it {should have_content("Eudora") }
		end # end valid submission
	end#end forget page

	describe "edit password page" do
		let(:token) {"KAXq4MFi2BdhprxoRxz3cQ"}
    let(:password_forgetter) { FactoryGirl.create(:user, password_reset_token: token, password_reset_sent_at: 1.hour.ago) }
    let(:user) { User.find_by(password_reset_token: token) }
		before do
			  #visit "/password_resets/KAXq4MFi2BdhprxoRxz3cQ/edit"
				visit edit_password_reset_path(password_forgetter.password_reset_token)
				#visit user_path(password_forgetter)
				
		end
				
				specify { expect(password_forgetter).to eq user }
      	specify { expect(password_forgetter.password_reset_token).to eq token }
        it { should have_title("Reset Password") }
        it { should have_content("Reset Password") }
				describe "entering invalid information" do
					before { click_button "Update Password" }
					it { should have_content("invalid") }
				end # end entering invalid info



	end # end edit password page
	
end
