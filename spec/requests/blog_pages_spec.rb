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
	
	describe "New Blog Page" do
		let(:blog) { FactoryGirl.create(:blog) }
		describe "should block access with invalid HTTP auth" do
			before do			
				visit new_blog_path
			end
			
			it { should_not have_title(("#{base_title} | New Blog")  ) }
			it { should_not have_content('New Blog') }
			#assert_equal 401, page.status_code
      specify { expect(page.status_code).to  eq 401 }
		end
	end #new blog page



end # end Blog pages
