class BikeShareApp < Sinatra::Base
  get '/stations' do
    @stations = Station.all

    erb :"stations/index"
    # haml :"stations/index"
  end

  # get '/stations/new' do
  #   erb :"stations/new"
  # end

  get '/stations/:id' do
    @station = Station.find_by(id: params[:id])

    erb :"stations/show"
  end

  get '/stations/:id/edit' do
    @station = Station.find_by(id: params[:id])

    erb :"stations/edit"
  end

  put '/station/:id' do
    station = Station.find_by(id: params[:id])
    station.update_attributes(:name              => params[:name],
                              :latitude          => params[:latitude],
                              :longitude         => params[:longitude],
                              :dock_count        => params[:dock_count],
                              :installation_date => params[:installation_date])

    redirect '/stations'
  end

  delete '/stations/:id' do
    Station.find_by(id: params[:id]).destroy

    redirect '/stations'
  end
end
