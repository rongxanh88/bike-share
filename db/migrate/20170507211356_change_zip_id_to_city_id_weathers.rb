class ChangeZipIdToCityIdWeathers < ActiveRecord::Migration[5.0]
  def change
    remove_column :weathers, :zip_code_id
    add_column :weathers, :city_id, :integer
  end
end
