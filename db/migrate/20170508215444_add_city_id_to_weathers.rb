class AddCityIdToWeathers < ActiveRecord::Migration[5.0]
  def change
    add_reference :weathers, :city, index: true, foreign_key: true
  end
end
