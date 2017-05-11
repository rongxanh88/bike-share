class CreateZipCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :zip_codes do |t|
      t.integer :zip_code, null: false
    end
  end
end
