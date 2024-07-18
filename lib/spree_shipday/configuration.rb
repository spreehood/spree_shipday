module SpreeShipday
  class Configuration < Spree::Preferences::Configuration
    attr_accessor :api_key

   # Some example preferences are shown below, for more information visit:
   # https://docs.spreecommerce.org/developer/contributing/creating-an-extension

   # preference :enabled, :boolean, default: true
   # preference :dark_chocolate, :boolean, default: true
   # preference :color, :string, default: 'Red'
   # preference :favorite_number, :integer
   # preference :supported_locales, :array, default: [:en]
    
    def initialize
      @api_key = nil
    end
  end
end
