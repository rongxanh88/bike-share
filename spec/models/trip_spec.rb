require_relative "../spec_helper"
require 'pry'

RSpec.describe Trip do
  before(:each) do
    subscriber = Subscription.create(name: "subscriber")
    customer = Subscription.create(name: "customer")

    Trip.create!(duration: 63, start_date: '10/12/2012', end_date: '22/12/2012', start_station_id: 62, end_station_id: 66, bike_id: 520, subscription_id: subscriber.id)
    Trip.create!(duration: 85, start_date: '10/12/2012', end_date: '10/12/2012', start_station_id: 62, end_station_id: 62, bike_id: 520, subscription_id: subscriber.id)
    Trip.create!(duration: 70, start_date: '10/10/2012', end_date: '10/10/2012', start_station_id: 66, end_station_id: 66, bike_id: 793, subscription_id: customer.id)
    Trip.create!(duration: 70, start_date: '10/10/2012', end_date: '10/10/2012', start_station_id: 84, end_station_id: 66, bike_id: 793, subscription_id: customer.id)
  end

  describe "model method" do

    it "returns the average duration of a ride" do

      duration_average = Trip.avg(:duration)
      expect(duration_average).to eq(72.0)
    end

  #   it "returns the longest ride" do

  #     longest = Trip.maximum(:duration)
  #     expect(longest).to eq(85)
  #   end

  #   it "returns the shortest ride" do

  #     shortest = Trip.minimum(:duration)
  #     expect(shortest).to eq(63)
  #   end

  #   it "returns the station where most rides start" do

  #     start_station = Trip.most_common_start_station
  #     expect(start_station).to eq(66)
  #   end
  end
end

  # Station with the most rides as a starting place.
  # Station with the most rides as an ending place.
  # Month by Month breakdown of number of rides with subtotals for each year.
  # Most ridden bike with total number of rides for that bike.
  # Least ridden bike with total number of rides for that bike.
  # User subscription type breakout with both count and percentage.
  # Single date with the highest number of trips with a count of those trips.
  # Single date with the lowest number of trips with a count of those trips.
