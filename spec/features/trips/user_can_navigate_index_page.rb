require_relative '../../spec_helper'

RSpec.describe "user can navigate the index page" do

  it "trips index displays" do
    visit('/trips')
    expect(current_path).to eq('/trips')
    expect(page).to have_content("Bike Trips")
  end

  it "can edit trip" do
    visit('/trips')
    click_link("Edit")
    expect(page).to have_content("Trip Editor")
  end

  it "can delete trip" do

  end

  it "can create trip" do

  end

  it "can show one trip" do

  end

  it "can navigate to the next page" do

  end
end