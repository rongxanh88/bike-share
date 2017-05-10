require_relative '../../spec_helper'
require_relative '../../station_city_creation_module'
require "pry"

RSpec.describe "user can navigate to all stations list and edit information" do
  include StationCityCreator

    it "they see stations" do
      #user can navigate to the main page
      visit('/')
      #user is redirected to the stations page
      expect(current_path).to eq('/stations')
      #user sees the welcome message
      expect(page).to have_content("Bike Stations")
    end

    it "they can create a station" do
    create_objects
    expect(current_path).to eq('/stations')
    #user can click on create a new station
    click_on 'Create a New Station'
    #user can fill in station information
    fill_in 'station[name]', with: 'Phil'
    fill_in 'station[latitude]', with: 33.33
    fill_in 'station[longitude]', with: 32.33
    fill_in 'station[dock_count]', with: 22
    fill_in 'station[installation_date]', with: 22/12/2012
    choose 'San Francisco'
    click_on 'submit'
    #user is redirected to stations page
    expect(current_path).to eq('/stations')
    #user can see the newly created station
    expect(page).to have_content("Phil")
    #user can navigate to station dashboard
    click_on "Station: Phil"
    save_and_open_page
    # save_and_open_page
    end
end
