module Spree
  module Api
    module V2
      class ShipdayController < Spree::Api::V2::ResourceController

        def webhooks
          order_status = params[:shipday][:order_status]
          order_id = params[:shipday][:order][:id]

          shipday_order = Spree::ShipdayOrder.find_by(shipday_order_id: order_id)

          if shipday_order.present?
            shipday_order.update(status: order_status)
          else
            Rails.logger.info "Shipday order not found"
          end
        end
      end
    end
  end
end
