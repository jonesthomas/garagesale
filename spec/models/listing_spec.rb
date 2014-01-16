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

###########################################Blank Content####
  describe "with blank title" do
    before { @listing.title = " " }
    it { should_not be_valid }
  end
  describe "with blank user_id" do
    before { @listing.user_id = " " }
    it { should_not be_valid }
  end
  describe "with blank specific_location" do
    before { @listing.specific_location = " " }
    it { should_not be_valid }
  end
  describe "with blank zip_code" do
    before { @listing.zip_code = " " }
    it { should_not be_valid }
  end
  describe "with blank price" do
    before { @listing.price = " " }
    it { should_not be_valid }
  end
  describe "with blank details" do
    before { @listing.details = " " }
    it { should_not be_valid }
  end
  describe "with blank active" do
    before { @listing.active = " " }
    it { should_not be_valid }
  end
#########################Content Validations ###############
  describe "with title that is too long" do
    before { @listing.title = "a" * 141 }
    it { should_not be_valid }
  end
  describe "with specific_location that is too long" do
    before { @listing.specific_location = "a" * 31 }
    it { should_not be_valid }
  end
  describe "with zip_code that is too long" do
    before { @listing.zip_code = 124598 }
    it { should_not be_valid }
  end
  describe "with zip_code that is too short" do
    before { @listing.zip_code = "1234" }
    it { should_not be_valid }
  end
  describe "with zip_code that is wrong tail format" do
    before { @listing.zip_code = "1234-123" }
    it { should_not be_valid }
  end
  describe "with zip_code that is correct 5 digit" do
    before { @listing.zip_code = "12345" }
    it { should be_valid }
  end
  describe "with zip_code that is correct 5 digit and suffix" do
    before { @listing.zip_code = "12345-1234" }
    it { should be_valid }
  end
  describe "with price wrong format" do
    before { @listing.price = 119.015 }
    it { should_not be_valid }
  end
  describe "with price right format" do
    before { @listing.price = 119.01 }
    it { should be_valid }
  end
  describe "with details that is too long" do
    before { @listing.specific_location = "a" * 10001 }
    it { should_not be_valid }
  end

end
