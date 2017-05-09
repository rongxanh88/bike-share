require_relative "../spec_helper"
#require 'pry'

#INNER JOIN STATION ID TO TABLE START STATION ID
#Station.joins("INNER JOIN trips ON trips.start_station_id = station.id")

RSpec.describe Trip do
  before(:each) do
    subscriber = Subscription.create(name: "subscriber")
    customer = Subscription.create(name: "customer")

    Trip.create!(duration: 63, start_date: '10/12/2012', end_date: '22/12/2012', start_station_id: 62, end_station_id: 66, bike_id: 520, subscription_id: subscriber.id)
    Trip.create!(duration: 85, start_date: '10/12/2012', end_date: '10/12/2012', start_station_id: 62, end_station_id: 62, bike_id: 520, subscription_id: subscriber.id)
    Trip.create!(duration: 70, start_date: '10/10/2012', end_date: '10/10/2012', start_station_id: 66, end_station_id: 66, bike_id: 793, subscription_id: customer.id)
    Trip.create!(duration: 70, start_date: '10/10/2012', end_date: '10/10/2012', start_station_id: 84, end_station_id: 66, bike_id: 793, subscription_id: customer.id)
  end

  describe "number of rides started at this station" do

    it "returns the number of rides" do
      station1 = Station.create(name: "Los Gatos", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/12/2012')

      station2 = Station.create(name: "Los Hombres", latitude: 45.67, longitude: 95.12,
      dock_count: 56, installation_date: '22/12/2012')

      Trip.create!(duration: 63, start_date: '01/01/2013', end_date: '01/01/2013', start_station_id: 1, end_station_id: 2, bike_id: 520, subscription_id: 2)

      Trip.create!(duration: 23, start_date: '01/01/2013', end_date: '01/01/2013', start_station_id: 1, end_station_id: 2, bike_id: 520, subscription_id: 2)

      Trip.create!(duration: 63, start_date: '01/01/2013', end_date: '01/01/2013', start_station_id: 2, end_station_id: 1, bike_id: 520, subscription_id: 2)

      trips_made = ""
      #binding.pry
      expect(trips_made).to eq(2)
    end
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

    it "returns the least ridden bike" do
      unpopular_bike = Trip.least_common(:bike_id)
      expect(unpopular_bike).to eq(793)
    end

    it "returns the number of rides for a specific bike" do
      number_of_rides = Trip.where(bike_id: 520).count
      expect(number_of_rides).to eq(3)
    end

    it "returns the number of subscription types" do
      num_of_subscriptions = Trip.number_of_subscriptions(1)
      expect(num_of_subscriptions).to eq(1)
    end

    it "returns percentage of total subscriptions per type" do
      total_sub_type_1 = Trip.number_of_subscriptions(1)
      total_sub_type_2 = Trip.number_of_subscriptions(2)
      percentage_of_a_sub_1 = total_sub_type_1/(total_sub_type_1 + total_sub_type_2).to_f.round(2)
      expect(percentage_of_a_sub_1).to eq(0.25)
    end

    it "returns number of most rides by day" do
      popular_day = Trip.most_common(:start_date)
      day = '2012-12-10 00:00:00.000000000 +0000'
      expect(popular_day).to eq(day)
      number_of_rides = Trip.where(start_date: day).count
      expect(number_of_rides).to eq(2)
    end

    it "returns number of least rides by day" do
      unpopular_day = Trip.least_common(:start_date)
      day = '2012-10-11 00:00:00.000000000 +0000'
      expect(unpopular_day).to eq(day)
      number_of_rides = Trip.where(start_date: day).count
      expect(number_of_rides).to eq(1)
    end
  end
end

# On an individual station show page add the following information:
#
# Number of rides started at this station.
# Number of rides ended at this station.
# Most frequent destination station (for rides that began at this station).
# Most freuqnet origination station (for rides that ended at this station).
# Date with the highest number of trips started at this station.
# Most frequent zip code for users starting trips at this station.
# Bike ID most frequently starting a trip at this station.
