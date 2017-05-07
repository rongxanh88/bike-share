require 'pry'

class BikeShareApp < Sinatra::Base
  get '/stations' do
    @stations = Station.all

    erb :"stations/index"
    # haml :"stations/index"
  end

  get '/stations/:id/edit' do
    @station = Station.find_by(id: params[:id])

    erb :"stations/#{@station.id}/edit"
  end

  delete '/station/:id' do
    Station.find_by(id: params[:id]).destroy

    redirect '/stations'
  end
end
