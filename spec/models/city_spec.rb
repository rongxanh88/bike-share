require_relative "../spec_helper"

RSpec.describe City do
  describe ".name" do
    it "returns the names of our cities" do
      city = City.create(name: "San Jose")

      expect(city.name).to eq("San Jose")
    end
  end

  describe "validations" do
    it "is invalid without a name" do
      city = City.create

      expect(city).to_not be_valid
    end
  end
end
