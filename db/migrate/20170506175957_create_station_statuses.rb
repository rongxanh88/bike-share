class CreateStationStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :station_statuses do |t|
      t.integer  :station_id, null: false
      t.integer  :bikes_available, null: false
      t.integer  :docks_available, null: false
      t.datetime :time, null: false
    end
  end
end
