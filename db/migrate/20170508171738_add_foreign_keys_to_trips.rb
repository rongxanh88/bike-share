class AddForeignKeysToTrips < ActiveRecord::Migration[5.0]
  def change
    add_reference :trips, :zip_code, index: true, foreign_key: true
    add_reference :trips, :subscription, index: true, foreign_key: true
  end
end
