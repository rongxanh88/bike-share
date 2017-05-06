require 'pry'

class BikeShareApp < Sinatra::Base
  get '/stations' do
    @stations = Station.all

    erb :"stations/index"
    # haml :"stations/index"
  end
end
