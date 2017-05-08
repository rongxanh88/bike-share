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
    create_stations
    create_cities
    expect(current_path).to eq('/stations')
    #user can click on create a new station
    click_on 'Create a New Station'
    #user can fill in station information
    fill_in 'name', with: 'Phil'
    fill_in 'latitude', with: 33.33
    fill_in 'longitude', with: 32.33
    fill_in 'dock_count', with: 22
    fill_in 'installation_date', with: 12/22/2012
    fill_in 'city', with: 'San Francisco'
    click_on 'Submit'
    #user is redirected to stations page
    expect(current_path).to eq('/stations')
    #user can see the newly created station
    expect(page).to have_content("Triss")
    expect(page).to have_content("Dante")
    expect(page).to have_content("Phil")
    save_and_open_page
    end
end
