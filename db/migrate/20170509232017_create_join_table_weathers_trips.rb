class CreateJoinTableWeathersTrips < ActiveRecord::Migration[5.0]
  def change
    create_join_table :weathers, :trips do |t|
      t.index [:weather_id, :trip_id]
    end
  end
end
