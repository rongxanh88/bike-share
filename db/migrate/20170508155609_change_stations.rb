class ChangeStations < ActiveRecord::Migration[5.0]
  def change
    add_reference :stations, :city, index: true, foreign_key: true
  end
end
