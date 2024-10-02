# frozen_string_literal: true

module Spree
  class ShipdayOrder < ApplicationRecord
    belongs_to :spree_order, class_name: 'Spree::Order'
  end
end
