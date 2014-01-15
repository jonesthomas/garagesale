require 'spec_helper'

describe Listing do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @listing = user.listings.build(title: "Lorem ipsum", user_id: user.id, specific_location: "Fallbrook", price: 110.10, details: "This is cool.", active:true, zip_code:90210)
  end

  subject { @listing }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
 	it { should respond_to(:specific_location) }
 	it { should respond_to(:zip_code) }
 	it { should respond_to(:price) }
 	it { should respond_to(:details) }
 	it { should respond_to(:active) }
	it { should respond_to(:user) }
	its(:user) { should eq user }
	it {should be_valid}

	describe "when user_id is not present" do
		before {@listing.user_id=nil}
		it {should_not be_valid}
	end# when user_id is not present

	describe "when title is not present" do
		before {@listing.title=nil}
		it {should_not be_valid}
	end# when title is not present

	describe "when specific_location is not present" do
		before {@listing.specific_location=nil}
		it {should_not be_valid}
	end# when specific location is not present

	describe "when zip_code is not present" do
		before {@listing.zip_code=nil}
		it {should_not be_valid}
	end# when zip code is not present

	describe "when price is not present" do
		before {@listing.price=nil}
		it {should_not be_valid}
	end# when price is not present

	describe "when details is not present" do
		before {@listing.details=nil}
		it {should_not be_valid}
	end# when details is not present

	describe "when active is not present" do
		before {@listing.active=nil}
		it {should_not be_valid}
	end# when active is not present

end
