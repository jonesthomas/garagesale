require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")


  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
	it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
	it { should respond_to(:password_reset_token) } 
	it { should respond_to(:password_reset_sent_at) }
	it { should respond_to(:listings) }

  it { should be_valid }
  it { should_not be_admin }

	describe "when password_reset_token is already taken case sensitive"  do
		let(:token) {"KAXq4MFi2BdhprxoRxz3cQ"}

		before do
    @user2 = User.new(name: "Example User2", email: "me2@example.com",
                     password: "foobar", password_confirmation: "foobar")
			@user.password_reset_token = token
			@user.password_reset_sent_at = 1.hour.ago
			@user2.password_reset_token = token
			@user2.password_reset_sent_at = 1.hour.ago
			@user2.save!
			@user.save # don't use the exclamation, it won't go into the database, as expected!
		end
		it {should_not be_valid}
	end# end password reset token is taken

	describe "when password_reset_token is already taken but not case sensitive"  do
		let(:token) {"KAXq4MFi2BdhprxoRxz3cQ"}
		let(:token2) {"KAXq4MFi2BdhprxoRxz3cq"}
		before do
    @user2 = User.new(name: "Example User2", email: "me2@example.com",
                     password: "foobar", password_confirmation: "foobar")
			@user.password_reset_token = token
			@user.password_reset_sent_at = 1.hour.ago
			@user2.password_reset_token = token2
			@user2.password_reset_sent_at = 1.hour.ago
			@user2.save!
			@user.save # don't use the exclamation, it won't go into the database, as expected!
		end
		it {should be_valid}
	end# end password reset token is taken but it's not case sensitive

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end #end admin attributes

	describe "remember token" do
		before { @user.save }
		its	(:remember_token) {should_not be_blank}
	end #end remember token
	
	describe "with a password that is too short" do
		before {@user.password=@user.password_confirmation="a"*5 }
		it {should be_invalid}
	end #end password too short

	describe "return value of authenticate method" do
		before {@user.save}
		let (:found_user) {User.find_by(email: @user.email)}
		
		describe "with valid password" do
			it {should eq found_user.authenticate(@user.password)    }
		end # end with valid password	

		describe "with invalid password" do
			let (:user_for_invalid_password) { found_user.authenticate("invalid")}
			it {should_not eq user_for_invalid_password}
			specify {expect(user_for_invalid_password).to be_false}
		end #end with invalid password
	end #end return value of authenticate method

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end # end name not present

	describe "when name is too long" do
		before {@user.name ="a"*51}
    it { should_not be_valid }
	end #end name too long
	
	describe "when email is not present" do
		before { @user.email = " "}
		it {should_not be_valid}
	end # end email is not present

 	describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end # end email format is not valid

 	describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end # end email format is valid

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it {should_not be_valid }
	end #end when email is taken

	describe "when password is not present" do
		before do
			@user = User.new(name: "Example User", email: "user@example.com",
                     password: " ", password_confirmation: " ")
		end

		it {should_not be_valid}
	end # end when password is not present

	describe "when password does not match confirmation" do
		before {@user.password_confirmation="mismatch"}
		it {should_not be_valid}
	end# end password does not match

  describe "listing associations" do

    before { @user.save }
    let!(:older_listing) do
      FactoryGirl.create(:listing, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_listing) do
      FactoryGirl.create(:listing, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right listings in the right order" do
      expect(@user.listings.to_a).to eq [newer_listing, older_listing]
    end
  end # end listing associations
end # User
