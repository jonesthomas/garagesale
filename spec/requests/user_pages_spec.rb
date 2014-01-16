require 'spec_helper'

describe "User pages" do
  let(:base_title) { "Eudora" }
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end # end pagination


    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end # end delete links
  end # end index

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(("#{base_title} | Sign up")  ) }

  end#end signup page

	describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update Your Profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end #end page

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end #end with invalid info

		describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end #end edit with valid info

  end #end edit page

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
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:l1) { FactoryGirl.create(:listing, user: user, title: "Foo") }
    let!(:l2) { FactoryGirl.create(:listing, user: user, title: "Bar") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "listing" do
      it { should have_content(l1.title) }
      it { should have_content(l2.title) }
      it { should have_content(user.listings.count) }
    end
  end # end profile page
end # end user pages

