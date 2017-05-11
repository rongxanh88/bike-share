class CreateWeathers < ActiveRecord::Migration[5.0]
  def change
    create_table :weathers do |t|
      t.date    :date, null: false
      t.float   :max_temp, null: false
      t.float   :mean_temp, null: false
      t.float   :min_temp, null: false
      t.float   :mean_humidity, null: false
      t.float   :mean_visibility, null: false
      t.float   :mean_wind_speed, null: false
      t.float   :precipitation, null: false
      # t.integer :zip_code_id, null: false
    end
  end
end
