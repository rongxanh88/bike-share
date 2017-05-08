class City < ActiveRecord::Base
  has_many :stations
  validates :name, presence: true, uniqueness: true
  belongs_to :weathers
  validates :name, presence: true, uniqueness: true

  def self.create_city_relationship(params)
    city = City.find_by(name: params)
    city.id
  end

end
