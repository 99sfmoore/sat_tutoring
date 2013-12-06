require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do

    it "should have the content 'New York Cares SAT Tutoring" do
      visit root_path
      expect(page).to have_content("New York Cares SAT Tutoring")
    end

  end

end
