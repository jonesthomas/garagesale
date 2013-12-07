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
		end #should block access
		

		describe "should block access with invalid password" do
			before do	
				basic_auth('admin1', 'wrong')					
				visit new_blog_path
			end
			
			it { should_not have_title(("#{base_title} | New Blog")  ) }
			it { should_not have_content('New Blog') }
			#assert_equal 401, page.status_code
      specify { expect(page.status_code).to  eq 401 }
		end #should block access


		describe "should block access with invalid user" do
			before do	
				basic_auth('me', 'ILcorporations1234!!')					
				visit new_blog_path
			end
			
			it { should_not have_title(("#{base_title} | New Blog")  ) }
			it { should_not have_content('New Blog') }
			#assert_equal 401, page.status_code
      specify { expect(page.status_code).to  eq 401 }
		end #should block access


		describe "should visit new blog page with valid password" do
			before do
				basic_auth('admin1', 'ILcorporations1234!!')			
				visit new_blog_path
			end
			
			it { should have_title(("#{base_title} | New Blog")  ) }
			it { should have_content('New Blog') }
      specify { expect(page.status_code).to  eq 200 }
		end #visit new blog page with valid password

		describe "creating a new blog" do
			let (:submit) {"Submit Blog"}			
			before do
				basic_auth('admin1', 'ILcorporations1234!!')
				visit new_blog_path
			end
	
			describe "with blank information" do
				it "should not create a blog" do
					expect {click_button submit }.not_to change(Blog, :count)
				end
			end #with blank

			describe "after submission" do
        before { click_button submit }

        it { should have_title('New Blog') }
        it { should have_content('error') }
      end #end after submission



			describe "with valid information" do
				before do
					fill_in "Title", 				with: "Blog 40"
					fill_in "Author", 				with:	"Justin Jones"
					fill_in "Body", 		with: "Made it"
				end 
				it "should create a blog" do
					expect {click_button submit}.to change(Blog, :count).by(1)
				end

				 describe "after saving the blog" do
		      before { click_button submit }
		      let(:blog) { Blog.find_by(title: "Blog 40") }
					it { should have_content(blog.author) }
					it { should have_link('Edit') }
					it { should have_link('Back') }
		      it { should have_title(blog.title) }
		      it { should have_selector('div.alert.alert-success', text: 'New Post') }
		    end #end after saving the blog	
			end #with valid information

		end#end creating a new blog

	end #new blog page
	
	##########################

	describe "edit blog page" do
    let(:blog) { FactoryGirl.create(:blog) }
    before do
			basic_auth('admin1', 'ILcorporations1234!!')
      visit edit_blog_path(blog)
    end

    describe "page" do
      it { should have_content("Edit Post") }
      it { should have_title("Edit Post") }

    end #end page

    describe "with invalid information" do
      let(:new_title)  { " " }
			before do

        fill_in "Title",             with: new_title
        click_button "Save changes"
      end

      it { should have_content('error') }
    end #end with invalid info

		describe "with valid information" do
      let(:new_title)  { "New Name" }
      let(:new_author) { "JJ" }
			let(:new_body)   {"Yep its new"}
      before do
        fill_in "Title",             with: new_title
        fill_in "Author",            with: new_author
        fill_in "Body",         		 with: new_body 
        click_button "Save changes"
      end

      it { should have_title(new_title) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(blog.reload.title).to  eq new_title }
      specify { expect(blog.reload.author).to eq new_author }
      specify { expect(blog.reload.body).to eq new_body }
    end #end edit with valid info

  end #end edit page

##########################3

end # end Blog pages
