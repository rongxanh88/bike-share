require_relative '../../spec_helper'
require_relative '../../station_city_creation_module'
require "pry"

RSpec.describe "user can navigate to weather index page" do
  include StationCityCreator

  it "They can see the weather index page" do
    visit ('/conditions')
    create_objects
    create_weather_objects
    expect(current_path).to eq('/conditions')
    expect(page).to have_content("Weather Conditions")
    save_and_open_page
  end

end
