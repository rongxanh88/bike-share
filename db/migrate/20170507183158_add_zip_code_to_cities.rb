class AddZipCodeToCities < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :zip_code_id, :integer
  end
end
