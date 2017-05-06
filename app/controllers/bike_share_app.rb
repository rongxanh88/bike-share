class BikeShareApp < Sinatra::Base
  get '/stations' do
    @stations = Station.all

    haml :"stations/index"
  end
end
