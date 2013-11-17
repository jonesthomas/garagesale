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
		    it { should have_content('All posts') }
	end #index

end # end Blog pages
