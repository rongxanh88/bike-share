class Zip_Code < ActiveRecord::Base
  belongs_to :city
  belongs_to :weather
  validates :zip_code, presence: true, uniqueness: true
end