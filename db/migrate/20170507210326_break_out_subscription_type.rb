class BreakOutSubscriptionType < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :subscription_type
    add_column :trips, :subscription_id, :integer

    create_table :subscriptions do |t|
      t.text :name, null: false
    end
  end
end
