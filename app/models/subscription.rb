class Subscription < ActiveRecord::Base
  belongs_to :trips
  validates :subscription, presence: true
end