require_relative "../spec_helper"

RSpec.describe Station do
  describe "read the attributes of our station" do
    it "returns the names of our stations" do
      Station.create(name: "Phil", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/12/2012')

      station = Station.find_by(name: "Phil")

      expect(station.name).to eq("Phil")
    end

    it "returns the dock count of station" do
      Station.create(name: "Phil", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/12/2012')

      station = Station.find_by(name: "Phil")

      expect(station.dock_count).to eq(23)
    end

    it "returns the installation date of our stations" do
      Station.create(name: "Phil", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/12/2012')

      station = Station.find_by(name: "Phil")
      date = Date.new(2012,12,22)
      expect(station.installation_date).to eq(date)
    end
  end

  describe "validations" do
    it "is invalid without a name" do
      station = Station.create(latitude: 333.333, longitude: 333.22, dock_count: 3, installation_date: '22/12/2012')

      expect(station).to_not be_valid
    end

    it "is invalid without a latitude" do
      station = Station.create(name: "Station", longitude: 333.22, dock_count: 3, installation_date: '22/12/2012')

      expect(station).to_not be_valid
    end

    it "is invalid without a longitude" do
      station = Station.create(name: "Station", latitude: 333.22, dock_count: 3, installation_date: '22/12/2012')

      expect(station).to_not be_valid
    end

    it "is invalid without a dock_count" do
      station = Station.create(name: "Station", latitude: 33.22, longitude: 333.22, installation_date: '22/12/2012')

      expect(station).to_not be_valid
    end

    it "is invalid without a installation_date" do
      station = Station.create(name: "Station", latitude: 33.22, longitude: 333.22, dock_count: 12)

      expect(station).to_not be_valid
    end
  end

  describe "station model methods" do
    it "returns station with fewest docks" do
      Station.create(name: "Station1", latitude: 33.22, longitude: 333.22, dock_count: 12, installation_date: '22/12/2012')
      Station.create(name: "Station2", latitude: 33.22, longitude: 333.22, dock_count: 16, installation_date: '22/12/2012')
      Station.create(name: "Station3", latitude: 33.22, longitude: 333.22, dock_count: 18, installation_date: '22/12/2012')

      dock_count = Station.fewest(:dock_count)
      expect(dock_count).to eq(12)
    end

    it "returns station with most docks" do
      Station.create(name: "Station1", latitude: 33.22, longitude: 333.22, dock_count: 12, installation_date: '22/12/2012')
      Station.create(name: "Station2", latitude: 33.22, longitude: 333.22, dock_count: 16, installation_date: '22/12/2012')
      Station.create(name: "Station3", latitude: 33.22, longitude: 333.22, dock_count: 18, installation_date: '22/12/2012')

      dock_count = Station.most(:dock_count)
      expect(dock_count).to eq(18)
    end

    it "returns newest station" do
      Station.create(name: "Station1", latitude: 33.22, longitude: 333.22, dock_count: 12, installation_date: '22/12/2000')
      Station.create(name: "Station2", latitude: 33.22, longitude: 333.22, dock_count: 16, installation_date: '22/12/2012')
      Station.create(name: "Station3", latitude: 33.22, longitude: 333.22, dock_count: 18, installation_date: '22/12/2026')

      list = Station.newest_stations
      expect(list).to eq(["Station3"])
    end

    it "returns oldest station" do
      Station.create(name: "Station1", latitude: 33.22, longitude: 333.22, dock_count: 12, installation_date: '22/12/2000')
      Station.create(name: "Station2", latitude: 33.22, longitude: 333.22, dock_count: 16, installation_date: '22/12/2012')
      Station.create(name: "Station3", latitude: 33.22, longitude: 333.22, dock_count: 18, installation_date: '22/12/2026')

      list = Station.oldest_stations
      expect(list).to eq(["Station1"])
    end

    it "returns average station attribute" do
      Station.create(name: "Station1", latitude: 33.22, longitude: 333.22, dock_count: 2, installation_date: '22/12/2000')
      Station.create(name: "Station2", latitude: 33.22, longitude: 333.22, dock_count: 4, installation_date: '22/12/2012')
      Station.create(name: "Station3", latitude: 33.22, longitude: 333.22, dock_count: 6, installation_date: '22/12/2026')

      expect(Station.avg(:dock_count)).to eq(4)
    end
  end
end
