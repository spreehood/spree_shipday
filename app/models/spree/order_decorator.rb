module Spree
  module OrderDecorator
    def self.prepended(base)
      base.has_one :shipday_order, class_name: 'Spree::ShipdayOrder', foreign_key: 'spree_order_id'
    end
  end
end

Spree::Order.prepend(Spree::OrderDecorator)
