class ZipCode < ActiveRecord::Base
  validates :zip_code, presence: true, uniqueness: true
end