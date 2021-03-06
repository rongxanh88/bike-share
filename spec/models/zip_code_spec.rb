require_relative "../spec_helper"

RSpec.describe ZipCode do
  describe ".zip_code" do
    it "returns the zip code" do
      zip = ZipCode.create(zip_code: 90210)

      expect(zip.zip_code).to eq(90210)
    end
  end

  describe "validations" do
    it "is invalid without a zip code" do
      zip = ZipCode.create

      expect(zip).to_not be_valid
    end
  end
end
