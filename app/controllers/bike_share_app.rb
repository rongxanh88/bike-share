require "pry"

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
    @trips = Trip.all

    erb :"trips/index"
  end

  get '/trips/new' do
    erb :"trips/new"
  end

  get '/trips/:id' do
    @station = Trip.find_by(id: params[:id])

    erb :"trips/show"
  end

  get '/trips/:id/edit' do
    @station = trip.find_by(id: params[:id])

    erb :"trips/edit"
  end

  put '/trips/:id' do
    trip = trip.find_by(id: params[:id])
    trip.update_attributes(duration: params[:duration],
                          start_date: params[:start_date],
                          end_date: params[:end_date],
                          start_id_station: params[:start_id_station],
                          end_id_station: params[:end_id_station],
                          bike_id: params[:bike_id],
                          subscription_type: params[:subscription_type],
                          zip_code_id: params[:zip_code_id]
                          )

    redirect '/trips'
  end

  delete '/trips/:id' do
    trip.find_by(id: params[:id]).destroy

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
end
