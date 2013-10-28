require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Eudora" }

   describe "Home page" do

    it "should have the content 'Eudora'" do
      #visit '/static_pages/home'
			visit root_path
      expect(page).to have_content('Eudora')
    end

    it "should have the base title" do
      #visit '/static_pages/home'
			visit root_path
      expect(page).to have_title("Eudora")
    end

    it "should not have a custom page title" do
      #visit '/static_pages/home'
			visit root_path
      expect(page).not_to have_title('| Home')
    end
  end # end home

  describe "Help page" do

    it "should have the content 'Help'" do
      #visit '/static_pages/help'
			visit help_path
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      #visit '/static_pages/help'
			visit help_path
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      #visit '/static_pages/about'
			visit about_path
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      #visit '/static_pages/about'
			visit about_path
      expect(page).to have_title("#{base_title} | About Us")
    end
  end

  describe "Contact page" do

    it "should have the content 'Contact'" do
      #visit '/static_pages/contact'
			visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      #visit '/static_pages/contact'
			visit contact_path
      expect(page).to have_title("#{base_title} | Contact")
    end
  end # end Contact page

  describe "Browse page" do

    it "should have the content 'Browse'" do
      #visit '/static_pages/browse'
			visit browse_path
      expect(page).to have_content('Browse')
    end

    it "should have the title 'Browse'" do
      #visit '/static_pages/browse'
			visit browse_path
      expect(page).to have_title("#{base_title} | Browse")
    end
  end # end browse page


end
