class AddOrderStatusToShipday < ActiveRecord::Migration[7.1]
  def change
    add_column :spree_shipday_orders, :status, :string
  end
end
