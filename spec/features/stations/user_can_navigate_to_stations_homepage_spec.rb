require_relative '../../spec_helper'
# RSpec.describe "user can navigate to jockies n stuff" do
#   it "they see jockies" do
#     #user navigates to home page
#     Jockey.create(name: "Penelope")
#     visit('/')
#     #user clicks on jockey link
#     click_on 'View Jockeys'
#     expect(current_path).tocelar eq('/jockeys')
#     #user sees Jockeys
#     expect(page).to have_content("Penelope")
#     click_on 'Additional Info'
#     save_and_open_page
#   end
# end

RSpec.describe "user can navigate to all stations list and edit information" do
  it "they see stations" do
  #user can navigate to the main page
  station = Station.new(name: "Phil", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '12/22/2012')
  station.save
  visit('/')
  #user is redirected to the stations page
  expect(current_path).to eq('/stations')
  #user sees the welcome message
  expect(page).to have_content("Bike Stations")
  end

  it "they can create a station" do
  expect(current_path).to eq('/stations')
  # save_and_open_page

  end
end
