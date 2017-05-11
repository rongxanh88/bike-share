require_relative '../../spec_helper'
require_relative '../../station_city_creation_module'
require "pry"

RSpec.describe "user can navigate to different station dashboards" do
include StationCityCreator

  it "they see station dashboards" do
    #user can navigate to index
    visit('/')
    create_objects
    #user can click on station dashboard
    click_on "Station Dashboard"
    #user can see relevant information
    expect(page).to have_content("Phil")
    expect(page).to have_content("Station Dashboard")
  end

end
