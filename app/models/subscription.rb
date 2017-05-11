class Subscription < ActiveRecord::Base
  belongs_to :trips
  validates :name, presence: true
end