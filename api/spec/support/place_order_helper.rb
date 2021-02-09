# frozen_string_literal: true

module PlaceOrderHelper
  def self.customer(payload)
    payload.slice(:customer)[:customer]
  end

  def self.order(payload)
    payload.slice(:externalCode, :storeId, :subTotal, :deliveryFee, :total_shipping, :total, :dtOrderCreate)
  end

  def self.address(payload)
    payload.slice(:country, :state, :city, :district, :street, :complement, :latitude, :longitude, :postalCode, :number)
  end

  def self.items(payload)
    payload.slice(:items)[:items]
  end

  def self.payments(payload)
    payload.slice(:payments)[:payments]
  end
end
