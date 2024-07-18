# frozen_string_literal: true

module Spree
  module OrderDecorator
    def self.prepended(base)
      base.after_save :create_order_in_shipday
    end

    def create_order_in_shipday
      return unless completed?

      ShipdayService.new(self).create_order
    end
  end
end

Spree::Order.prepend(Spree::OrderDecorator)
