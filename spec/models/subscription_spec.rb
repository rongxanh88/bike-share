require_relative "../spec_helper"

RSpec.describe Subscription do
  describe ".subscription" do
    it "returns the subscription type" do
      sub = Subscription.create(name: "subscriber")
      
      expect(sub.name).to eq("subscriber")
    end
  end

  describe "validations" do
    it "is invalid without a name" do
      sub = Subscription.create

      expect(sub).to_not be_valid
    end
  end
end