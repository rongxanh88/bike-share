require_relative "../spec_helper"

RSpec.describe Station do
  describe ".name" do
    it "returns the names of our stations" do

      station = Station.create(name: "Phil", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '12/22/2012')

      expect(station.name).to eq("Phil")
    end
  end

  describe "validations" do
    it "is invalid without a name" do
      station = Station.create(latitude: 333.333, longitude: 333.22, dock_count: 3, installation_date: 12/12/12)

      expect(station).to_not be_valid
    end

    it "is invalid without a latitude" do
      station = Station.create(name: "Station", longitude: 333.22, dock_count: 3, installation_date: 12/12/12)

      expect(station).to_not be_valid
    end

    it "is invalid without a longitude" do
      station = Station.create(name: "Station", latitude: 333.22, dock_count: 3, installation_date: '12/12/12')

      expect(station).to_not be_valid
    end

    it "is invalid without a dock_count" do
      station = Station.create(name: "Station", latitude: 33.22, longitude: 333.22, installation_date: '12/12/12')

      expect(station).to_not be_valid
    end

    it "is invalid without a installation_date" do
      station = Station.create(name: "Station", latitude: 33.22, longitude: 333.22, dock_count: 12)

      expect(station).to_not be_valid
    end
  end
end
