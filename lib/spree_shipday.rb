require 'spree_core'
require 'spree_extension'
require 'spree_shipday/engine'
require 'spree_shipday/version'
require 'spree_shipday/configuration'

module SpreeShipday
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
