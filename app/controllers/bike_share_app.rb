require 'will_paginate'
require 'will_paginate/active_record'
require 'pry'

class BikeShareApp < Sinatra::Base
  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
    # haml :"stations/index"
  end

  get '/' do
    redirect '/stations'
  end

  get '/stations/new' do
    @cities = City.all
    erb :"stations/new"
  end

  get '/stations/:id' do
    @station = Station.find_by(id: params[:id])
    erb :"stations/show"
  end

  get '/stations/:id/edit' do
    @station = Station.find_by(id: params[:id])
    @cities = City.all
    erb :"stations/edit"
  end

  put '/station/:id' do
    station = Station.find(params[:id])
    station.update_attributes(:name              => params[:station][:name],
                              :latitude          => params[:station][:latitude],
                              :longitude         => params[:station][:longitude],
                              :dock_count        => params[:station][:dock_count],
                              :installation_date => params[:station][:installation_date],
                              :city_id => params[:city])

    redirect '/stations'
  end

  delete '/stations/:id' do
    Station.find_by(id: params[:id]).destroy

    redirect '/stations'
  end

  post '/stations' do
    station = Station.create(name: params[:station][:name],
                            latitude: params[:station][:latitude],
                            longitude: params[:station][:longitude],
                            dock_count: params[:station][:dock_count],
                            installation_date: params[:station][:installation_date])
    city = City.create_city_relationship(params[:city])
    station.update_attributes(:city_id => city)
    redirect '/stations'
  end

  get '/station-dashboard' do
    @station = Station

    erb :"stations/station-dashboard"
  end

  get '/trips' do
    @trips = Trip.all.paginate(:page => params[:page], :per_page => 30)

    erb :"trips/index"
  end

  get '/trips/new' do
    erb :"trips/new"
  end

  get '/trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    @trip_info = @trip.get_info

    erb :"trips/show"
  end

  get '/trips/:id/edit' do
    @trip = Trip.find_by(id: params[:id])
    @trip_info = @trip.get_info

    erb :"trips/edit"
  end

  put '/trips/:id' do
    binding.pry
    trip = Trip.find_by(id: params[:id])
    start_station = Station.find_by(name: params[:start_station])
    end_station = Station.find_by(name: params[:end_station])
    subscription = Subscription.find_by(name: params[:subscription])
    zip_code = ZipCode.find_or_create_by(zip_code: params[:zip_code].to_i)

    trip.update_attributes(duration: params[:duration].to_i,
                          start_date: params[:start_date],
                          end_date: params[:end_date],
                          start_station_id: start_station.id,
                          end_station_id: end_station.id,
                          bike_id: params[:bike_id].to_i,
                          subscription_id: subscription.id,
                          zip_code_id: zip_code.id
                          )
    redirect '/trips'
  end

  put '/create_trips' do
    start_station = Station.find_by(name: params[:start_station])
    end_station = Station.find_by(name: params[:end_station])
    subscription = Subscription.find_by(name: params[:subscription])
    zip_code = ZipCode.find_or_create_by(zip_code: params[:zip_code].to_i)

    trip = Trip.find_or_create_by(duration: params[:duration].to_i,
                          start_date: params[:start_date],
                          end_date: params[:end_date],
                          start_station_id: start_station.id,
                          end_station_id: end_station.id,
                          bike_id: params[:bike_id].to_i,
                          subscription_id: subscription.id,
                          zip_code_id: zip_code.id
                          )
    redirect "/trips/#{trip.id}"
  end

  delete '/trips/:id' do
    Trip.find_by(id: params[:id]).destroy

    redirect '/trips'
  end

  post '/trips' do
    trip = trip.new(duration: params[:duration],
                          start_date: params[:start_date],
                          end_date: params[:end_date],
                          start_id_station: params[:start_id_station],
                          end_id_station: params[:end_id_station],
                          bike_id: params[:bike_id],
                          subscription_type: params[:subscription_type],
                          zip_code_id: params[:zip_code_id]
                          )
    trip.save
    redirect '/trips'
  end

  get '/trip-dashboard' do
    @trip = Trip
    @station = Station

    erb :"trips/trip-dashboard"
  end

  get '/conditions' do
    @conditions = Weather.all
    erb :"conditions/index"
  end

  get '/condition/:id' do
    @condition = Weather.find(params[:id])
    city_id = @condition.city_id
    @city = City.find(city_id)
    erb :"conditions/show"
  end

  get '/conditions/new' do
    @cities = City.all
    erb :"conditions/new"
  end

  get '/condition/:id/edit' do
    @condition = Weather.find(params[:id])
    @cities = City.all
    erb :"conditions/edit"
  end

  post '/conditions' do
    condition = Weather.new(date: params[:condition][:date],
                          max_temp: params[:condition][:max_temp],
                          mean_temp: params[:condition][:mean_temp],
                          min_temp: params[:condition][:min_temp],
                          mean_humidity: params[:condition][:mean_humidity],
                          mean_visibility: params[:condition][:mean_visibility],
                          mean_wind_speed: params[:condition][:mean_wind_speed],
                          precipitation: params[:condition][:precipitation])

    city = City.find_by(name: params[:city])
    condition.update_attributes(:city_id => city.id)
    condition.save
    redirect '/conditions'
  end

  put '/condition/:id' do
    condition = Weather.find(params[:id])
    condition.update_attributes(:date              => params[:condition][:date],
                              :max_temp          => params[:condition][:max_temp],
                              :mean_temp         => params[:condition][:mean_temp],
                              :min_temp        => params[:condition][:min_temp],
                              :mean_humidity => params[:condition][:mean_humidity],
                              :mean_visibility => params[:condition][:mean_visibility],
                              :mean_wind_speed => params[:condition][:mean_wind_speed],
                              :precipitation => params[:condition][:precipitation],
                              :city_id => params[:city])

    redirect '/conditions'
  end

  delete '/condition/:id' do
    Weather.find_by(id: params[:id]).destroy

    redirect '/conditions'
  end

end
