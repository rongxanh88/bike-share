class ZipCode < ActiveRecord::Base
  validates :zip_code, presence: true, uniqueness: true
  
  def self.validate(zip_code)
    zip_code.to_s.split("").size > 5 ? 0 : zip_code
  end
end
