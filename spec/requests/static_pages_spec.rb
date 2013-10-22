require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Eudora'" do
      visit '/static_pages/home'
      expect(page).to have_content('Eudora')
    end
  end #end home page

	describe "Help page" do
		it "should have the content 'Help' " do
 			visit '/static_pages/help'
      expect(page).to have_content('Help')
		end
	end # end Help page


end # end of Static Pages
