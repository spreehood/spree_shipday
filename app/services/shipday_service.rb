# frozen_string_literal: true

require 'net/http'
require 'json'

class ShipdayService
  SHIPDAY_API_URL = 'https://api.shipday.com/orders'

  def initialize(order)
    @order = order
    @ship_address = order.ship_address
    @bill_address = order.bill_address
  end

  def create_order
    uri = URI(SHIPDAY_API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json', 'Authorization' => "Basic #{SpreeShipday.configuration.api_key}" })
    request.body = order_payload.to_json

    response = http.request(request)
    handle_response(response)
  end

  private

  def order_payload
    {
      orderNumber: @order.number,
      customerName: customer_name,
      customerAddress: customer_address,
      customerEmail: @order.email,
      customerPhoneNumber: @ship_address.phone,
      restaurantName: @order.store.name,
      restaurantAddress: @order.store.address,
      restaurantPhoneNumber: @order.store.contact_phone
    }
  end

  def customer_name
    [@ship_address.firstname, @ship_address.lastname].join(' ')
  end

  def customer_address
    [@ship_address.address1, @ship_address.address2, @ship_address.city, @ship_address.state.name, @ship_address.zipcode, @ship_address.country.name].compact.join(', ')
  end

  def handle_response(response)
    case response
    when Net::HTTPSuccess
      Rails.logger.info("Shipday order created successfully for Spree order #{@order.number}")

      Spree::ShipdayOrder.create(spree_order_id: @order.id, shipday_order_id: JSON.parse(response.body)['orderId'])
    else
      Rails.logger.error("Failed to create Shipday order for Spree order #{@order.number}: #{response.body}")
    end
  end
end
