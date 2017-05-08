require_relative "../spec_helper"

RSpec.describe City do
  describe ".name" do
    it "returns the names of our cities" do
      city = City.create(name: "San Jose")

      expect(city.name).to eq("San Jose")
    end
  end

  describe ".zip_code_id" do
    it "returns the zip code id for one of five cities" do
      city = City.create(name: "San Jose", zip_code_id: 5)

      expect(city.zip_code_id).to eq(5)
    end
  end

  describe "validations" do
    it "is invalid without a name" do
      city = City.create

      expect(city).to_not be_valid
    end
  end
end
