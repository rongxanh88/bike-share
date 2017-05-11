require_relative '../../spec_helper'

RSpec.describe "user can navigate view all weather dashboard headers" do

    it "they see temperature statistics" do
      #user can navigate to the weather dashboard
      visit('/conditions-dashboard')
      #user sees trips taken based on temperature
      expect(page).to have_content("Trips Taken Based on Temperature")
      save_and_open_page
    end

    it "they see temperature statistics" do
      #user can navigate to the weather dashboard
      visit('/conditions-dashboard')
      #user sees Trips Taken Based on Precipitation
      expect(page).to have_content("Trips Taken Based on Precipitation")
      save_and_open_page
    end

    it "they see temperature statistics" do
      #user can navigate to the weather dashboard
      visit('/conditions-dashboard')
      #user sees Trips Taken Based on Average Wind Speed
      expect(page).to have_content("Trips Taken Based on Average Wind Speed")
      save_and_open_page
    end

    it "they see temperature statistics" do
      #user can navigate to the weather dashboard
      visit('/conditions-dashboard')
      #user sees Trips Taken Based on Average Visibility
      expect(page).to have_content("Trips Taken Based on Average Visibility")
      save_and_open_page
    end
end
