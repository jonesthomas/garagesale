require 'spec_helper'

describe Blog do
	  before { @blog = Blog.new(title: "First Blog", body: "a*1000", author: "Justin Jones") }

  subject { @blog }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
	it { should respond_to(:author)}

 	describe "when title is not present" do
    before { @blog.title = " " }
    it { should_not be_valid }
  end

	describe "when author is not present" do
    before { @blog.author = " " }
    it { should_not be_valid }
  end

	describe "when author is too long" do
    before { @blog.author = "a"*51 }
    it { should_not be_valid }
  end


 	describe "when body is not present" do
    before { @blog.body = " " }
    it { should_not be_valid }
  end

	describe "when title is too long " do
		before  {@blog.title="a" *141 } 
		it {should_not be_valid}
	end # title is too long

	describe "when body is too long " do
		before  {@blog.title="a" *10001 } 
		it {should_not be_valid}
	end # body is too long

	describe "blog order" do
		let!(:older_blog) do
			FactoryGirl.create(:blog, created_at: 1.day.ago)
		end

		let!(:newer_blog) do
			FactoryGirl.create(:blog, created_at: 1.hour.ago)
		end

		
		it "should have the blogs in the right order" do
			expect(Blog.all.to_a).to eq [newer_blog, older_blog]
		end
	end #blog order
end # end the blog

