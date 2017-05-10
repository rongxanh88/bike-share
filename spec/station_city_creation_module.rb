
module StationCityCreator
  def create_objects
    city_1 = City.create(name: "San Jose")
    city_2 = City.create(name: "Redwood City")
    city_3 = City.create(name: "Mountain View")
    city_4 = City.create(name: "Palo Alto")
    city_5 = City.create(name: "San Francisco")
    station_1 = Station.create(name: "Phil", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/12/2012',city_id: city_1.id)
    station_2 = Station.create(name: "Triss", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/11/2012',city_id: city_3.id)
    station_3 = Station.create(name: "Dante", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/10/2012',city_id: city_5.id)
  end


end
