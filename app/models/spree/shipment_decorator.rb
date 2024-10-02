module Spree
  module ShipmentDecorator
    def self.prepended(base)
      base.state_machine.after_transition to: :shipped, do: :create_shipday_order

      base.after_save :update_shipment_status
    end

    private

    def create_shipday_order
      if shipping_method.name == 'Shipday'
        return if Spree::ShipdayOrder.find_by(spree_order_id: order.id)

        ShipdayService.new(order).create_order
      end
    end

    def update_shipment_status
      return unless Spree::ShipdayOrder.find_by(spree_order_id: order.id)

      if order.shipday_order.status == 'FAILED_DELIVERY'
        update_columns(state: 'failed')
      end
    end
  end
end

Spree::Shipment.prepend(Spree::ShipmentDecorator)
