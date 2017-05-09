require_relative "../spec_helper"
require 'pry'

#INNER JOIN STATION ID TO TABLE START STATION ID
#Station.joins("INNER JOIN trips ON trips.start_station_id = station.id")
#remove this line after commit

RSpec.describe Trip do
  before(:each) do
    subscriber = Subscription.create(name: "subscriber")
    customer = Subscription.create(name: "customer")

    bike = Bike.new(name: 0987)

    Trip.create!(duration: 63, start_date: '10/12/2012', end_date: '22/12/2012', start_station_id: 62, end_station_id: 66, bike_id: bike.id, subscription_id: 2)
    Trip.create!(duration: 85, start_date: '10/12/2012', end_date: '10/12/2012', start_station_id: 62, end_station_id: 62, bike_id: 520, subscription_id: 2)
    Trip.create!(duration: 70, start_date: '10/10/2012', end_date: '10/10/2012', start_station_id: 66, end_station_id: 66, bike_id: 520, subscription_id: 2)
    Trip.create!(duration: 70, start_date: '11/10/2012', end_date: '10/10/2012', start_station_id: 84, end_station_id: 66, bike_id: 793, subscription_id: 1)

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

    it "returns the least ridden bike" do

      unpopular_bike = Trip.least_common(:bike_id)
      #binding.pry

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

    it "returns number of trips started at station id" do

      num_trips = Trip.started_at(1)
      expect(num_trips).to eq(3)
    end

    it "returns number of trips ended at station id" do

      num_trips = Trip.started_at(1)
      expect(num_trips).to eq(3)
    end

    it "returns the most common end station id for each start station" do

      end_stations_collection = end_stations_per_start_station(1)
      popular_end_station = m_common_of(end_stations_collection)
      expect(popular_end_station).to eq(3)
    end

    it "returns the most frequent origination station id for each end station" do

      start_stations_collection = start_stations_per_end_station(1)
      popular_start_station = m_common_of(start_stations_collection)
      expect(popular_start_station).to eq(3)
    end

    it "returns the most popular date for trips started at each station" do

      date_collection = start_date_per_station(1)
      popular_start_date = m_common_of(date_collection)
      date = '2012-12-10 00:00:00.000000000 +0000'
      expect(popular_start_date).to eq(date)
    end

    it "returns most frequent zip code for users at each station" do

      #We Need the Zip Code for customers saved for this test
    end

    it "returns the most popular bike id started from each station" do

      bike_id_collection = bikes_started_per_station(1)
      popular_bike = m_common_of(bike_id_collection)
      expect(popular_bike).to eq(520)
    end
  end
end
