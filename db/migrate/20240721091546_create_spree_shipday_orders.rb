class CreateSpreeShipdayOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :spree_shipday_orders do |t|
      t.integer :spree_order_id
      t.integer :shipday_order_id

      t.timestamps
    end

    add_index :spree_shipday_orders, :spree_order_id
    add_index :spree_shipday_orders, :shipday_order_id
    add_index :spree_shipday_orders, [:spree_order_id, :shipday_order_id], unique: true, name: 'index_spree_shipday_orders_on_spree_and_shipday_order_ids'
  end
end
