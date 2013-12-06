require 'spec_helper'

describe "SitePages" do
   
   subject { page }

   describe "new site page" do
    before { visit new_site_path }

    it { should have_content('Initialize site') }
    it { should have_title('Site intialization')}
  end
end
