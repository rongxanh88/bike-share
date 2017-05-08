require_relative "../spec_helper"
#require 'pry'

RSpec.describe Trip do
  before(:each) do
    Trip.create!(duration: 63, start_date: '10/12/2012', end_date: '22/12/2012', start_station_id: 62, end_station_id: 66, bike_id: 520, subscription_id: 4)
    Trip.create!(duration: 85, start_date: '10/12/2012', end_date: '10/12/2012', start_station_id: 62, end_station_id: 62, bike_id: 520, subscription_id: 4)
    Trip.create!(duration: 70, start_date: '10/10/2012', end_date: '10/10/2012', start_station_id: 66, end_station_id: 66, bike_id: 520, subscription_id: 2)
    Trip.create!(duration: 70, start_date: '10/10/2012', end_date: '10/10/2012', start_station_id: 84, end_station_id: 66, bike_id: 793, subscription_id: 2)
  end

  describe "model method" do

    it "returns the average duration of a ride" do

      duration_average = Trip.avg(:duration)
      expect(duration_average).to eq(72.0)
    end

    it "returns the longest ride" do

      longest = Trip.maximum(:duration)
      expect(longest).to eq(85)
    end

    it "returns the shortest ride" do

      shortest = Trip.minimum(:duration)
      expect(shortest).to eq(63)
    end

    it "returns the station where most rides start" do

      start_station = Trip.most_common(:start_station_id)
      expect(start_station).to eq(62)
    end

    it "returns the station where the most rides end" do

      end_station = Trip.most_common(:end_station_id)
      expect(end_station).to eq(66)
    end

    it "returns number of rides by month" do

      october_rides = Trip.rides_by_month(10, 2012)
      expect(october_rides).to eq(2)
    end

    it "returns number of rides per year" do

      year1_rides = Trip.rides_by_year(2012)
      expect(year1_rides).to eq(4)
    end

    it "returns the most ridden bike" do

      popular_bike = Trip.most_common(:bike_id)
      expect(popular_bike).to eq(520)
    end

    it "returns the number of rides for a specific bike" do
      
    end
  end
end


# Month by Month breakdown of number of rides with subtotals for each year.
# Most ridden bike with total number of rides for that bike.
# Least ridden bike with total number of rides for that bike.
# User subscription type breakout with both count and percentage.
# Single date with the highest number of trips with a count of those trips.
# Single date with the lowest number of trips with a count of those trips.
