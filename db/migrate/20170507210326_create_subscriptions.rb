class BreakOutSubscriptionType < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.text :name, null: false
    end
  end
end
