class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user,       foreign_key: true
      t.string     :amount,     null: false

      t.timestamps
    end
  end
end
