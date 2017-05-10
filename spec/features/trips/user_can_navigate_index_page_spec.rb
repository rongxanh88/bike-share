require './spec/spec_helper'

RSpec.describe "user can navigate the index page" do

  before(:each) do
    subscriber = Subscription.create(name: "Subscriber")
    customer = Subscription.create(name: "Customer")
    zip = ZipCode.create(zip_code: 80236)

    Trip.create!(duration: 63, start_date: '25/12/2012', end_date: '25/12/2012', start_station_id: 1, end_station_id: 2, bike_id: 1, subscription_id: 2, zip_code_id: 1)
    Trip.create!(duration: 85, start_date: '26/12/2012', end_date: '26/12/2012', start_station_id: 1, end_station_id: 2, bike_id: 1, subscription_id: 2, zip_code_id: 1)
    Trip.create!(duration: 70, start_date: '22/10/2012', end_date: '22/10/2012', start_station_id: 1, end_station_id: 2, bike_id: 1, subscription_id: 1, zip_code_id: 1)
    Trip.create!(duration: 70, start_date: '11/10/2012', end_date: '11/10/2012', start_station_id: 1, end_station_id: 2, bike_id: 1, subscription_id: 1, zip_code_id: 1)

    station1 = Station.create(name: "Los Gatos", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/12/2012')

    station2 = Station.create(name: "Los Hombres", latitude: 45.67, longitude: 95.12,
    dock_count: 56, installation_date: '22/12/2012')
  end

  it "trips index displays" do
    visit('/trips')
    expect(current_path).to eq('/trips')
    expect(page).to have_content("Bike Trips")
    expect(page).to have_content("Trip: 4")
  end

  it "can edit trip" do
    visit('/trips')
    click_link("Trip: 4")
    expect(current_path).to eq('/trips/4')
    click_link("Edit")
    expect(page).to have_content("Trip Editor")
    fill_in 'duration', with: '100'
    click_on "Update Trip"
  end

  it "can delete trip" do
    visit('/trips')
    click_link("Trip: 2")
    expect(current_path).to eq('/trips/2')
    click_on("Delete")
    expect(current_path).to eq('/trips')
    expect(page).to_not have_content("Trip: 2")
    # save_and_open_page
  end

  it "can create trip" do
    visit('/trips')
    click_link("Create a New Trip")
    fill_in 'start_date', with: "#{Time.new(2012,8,29)}"
    fill_in 'end_date', with: "#{Time.new(2012,8,29)}"
    fill_in 'duration', with: '99'
    fill_in 'start_station', with: "Los Gatos"
    fill_in 'end_station', with: "Los Gatos"
    fill_in 'bike_id', with: "1"
    fill_in 'zip_code', with: '80235'
    fill_in 'subscription', with: 'Subscriber'
    click_on 'Create Trip'
    expect(page).to have_content("Trip: 5")
  end

  it "can show one trip" do
    visit('/trips')
    click_link("Trip: 4")
    expect(current_path).to eq('/trips/4')
  end
end