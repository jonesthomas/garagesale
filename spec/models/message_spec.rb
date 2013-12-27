require 'spec_helper'

describe Message do
	  before { @message = Message.new(name: "Justin", email: "me@yahoo.com", body: "a*1000", ) }
  subject { @message }


  it { should respond_to(:body) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }

	describe "when email is not present" do
		before { @message.email = " "}
		it {should_not be_valid}
	end # end email is not present

 	describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @message.email = invalid_address
        expect(@message).not_to be_valid
      end
    end
  end # end email format is not valid

 	describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @message.email = valid_address
        expect(@message).to be_valid
      end
    end
  end # end email format is valid



#############
  describe "when name is not present" do
    before { @message.name = " " }
    it { should_not be_valid }
  end # end name not present

	describe "when name is too long" do
		before {@message.name ="a"*51}
    it { should_not be_valid }
	end #end name too long


 	describe "when body is not present" do
    before { @message.body = " " }
    it { should_not be_valid }
  end

	describe "when body is too long " do
		before  {@message.body="a" *10001 } 
		it {should_not be_valid}
	end # body is too long
end
