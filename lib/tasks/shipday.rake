namespace :shipday do
  desc 'Add Shipday Delivery shipping method'
  task add_shipping_method: :environment do
    unless Spree::ShippingMethod.exists?(name: 'Shipday')
      shipping_method = Spree::ShippingMethod.new(
        name: 'Shipday',
        calculator_type: 'Spree::Calculator::Shipping::FlatRate',
        display_on: 'both'
      )

      shipping_method.shipping_categories = Spree::ShippingCategory.all
      shipping_method.save!
      
      puts 'Shipday Delivery shipping method added.'
    else
      puts 'Shipday Delivery shipping method already exists.'
    end
  end
end
