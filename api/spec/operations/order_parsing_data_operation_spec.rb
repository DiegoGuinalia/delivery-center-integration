require 'spec_helper'

RSpec.describe OrderParsingDataOperation do
  let(:operation) { described_class }
  let(:result) { operation.call(params: payload) }

  describe 'parse data' do
    context 'when success' do
      let(:payload) { JSON.parse(SpecSupport.load_payload('payload_valid.json'), symbolize_names: true) }

      it { expect(result.success?).to be true }

      it { expect(result.customer_data).to eq(customer) }

      it { expect(result.order_data).to eq(order) }

      it { expect(result.address_data).to eq(address) }

      it { expect(result.items_data).to eq(items) }

      it { expect(result.payments_data).to eq(payments) }
    end

    context 'when failed' do
      let(:payload) { nil }

      it { expect(result.success?).to be false }

      it { expect(result.error).not_to be nil }
    end
  end

  def customer
    customer_data = payload[:buyer]
    {
      external_code: customer_data[:id],
      name: customer_data[:nickname],
      email: customer_data[:email],
      contact: customer_data[:phone][:area_code].to_s + customer_data[:phone][:number]
    }
  end

  def order
    order_data = payload.slice(:id, :store_id, :total_amount, :total_shipping, :total_amount_with_shipping, :date_created)
    {
      external_code: order_data[:id],
      store_id: order_data[:store_id],
      sub_total: order_data[:total_amount],
      delivery_fee: order_data[:total_shipping],
      total_shipping: order_data[:total_shipping],
      total: order_data[:total_amount_with_shipping],
      dtOrderCreate: order_data[:date_created]
    }
  end

  def address
    address_data = payload[:shipping][:receiver_address]
    {
      country: address_data[:country][:id],
      state: AddressParser::STATE_OPTIONS[:"#{address_data[:state][:name]}"],
      city: address_data[:city][:name],
      district: address_data[:neighborhood][:name],
      street: address_data[:street_name],
      complement: address_data[:comment],
      latitude: address_data[:latitude],
      longitude:  address_data[:longitude],
      postal_code: address_data[:zip_code],
      number: address_data[:street_number]
    }
  end

  def items
    order_items = payload[:order_items]

    items_data = []

    order_items.each do |order_item|
      items_data << {
        external_code: order_item[:item][:id],
        name: order_item[:item][:title],
        price: order_item[:unit_price],
        quantity: order_item[:quantity],
        total: order_item[:unit_price]
      }
    end

    items_data
  end

  def payments
    payments = payload[:payments]

    payments_data = []

    payments.each do |payment|
      payments_data << {
        type: payment[:payment_type].upcase,
        value: payment[:total_paid_amount]
      }
    end

    payments_data
  end
end
