require 'spec_helper'

describe "BlogPages" do
  let(:base_title) { "Eudora" }
  subject { page }

  describe "index" do
    let(:blog) { FactoryGirl.create(:blog) }
    before(:each) do
      visit blogs_path
    end
				it { should have_title(("#{base_title} | All Posts")  ) }
		    it { should have_content('All Posts') }

	    describe "pagination" do

		    before(:all) { 31.times { FactoryGirl.create(:blog) } }
		    after(:all)  { Blog.delete_all }

		    it { should have_selector('div.pagination') } #not working, not sure why
		    it "should list each blog" do
		      Blog.paginate(page: 1).each do |blog|
		        expect(page).to have_selector('li', text: blog.title)
		      end
		    end
    end # end pagination
	end #index

end # end Blog pages
