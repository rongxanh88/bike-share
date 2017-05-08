class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.text    :name, null: false
      t.float  :latitude, null: false
      t.float  :longitude, null: false
      t.integer :dock_count, null: false
      t.date    :installation_date, null: false
      # t.integer :city_id
    end
  end
end
