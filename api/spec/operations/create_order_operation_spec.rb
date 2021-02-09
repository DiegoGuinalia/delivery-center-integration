# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CreateOrderOperation do
  let(:operation) { described_class }
  let(:result) { operation.call(data) }
  let(:data) do
    {
      customer_data: PlaceOrderHelper.customer(payload),
      order_data: PlaceOrderHelper.order(payload),
      address_data: PlaceOrderHelper.address(payload),
      items_data: PlaceOrderHelper.items(payload),
      payments_data: PlaceOrderHelper.payments(payload)
    }
  end

  describe 'create order in database' do
    let(:payload) { JSON.parse(SpecSupport.load_payload('payload_create_order.json'), symbolize_names: true) }

    context 'when order exists in the database' do
      before { operation.call(data) }

      it { expect(result.success?).to be true }

      it { expect(result.customer).to be nil }

      it { expect(result.order).to be nil }

      it { expect(result.address).to be nil }

      it { expect(result.items).to be nil }

      it { expect(result.payments).to be nil }
    end

    context 'when customer and items exists in the database' do
      before do
        Customer.create(customer)
        Item.create(item)
      end

      it { expect(result.success?).to be true }

      it { expect(result.customer.name).to eq(data[:customer_data][:name]) }

      it { expect(result.items.first.name).to eq(data[:items_data].first[:name]) }
    end

    context 'when customer, order, address, items, payments does not exist in the database' do
      it { expect(result.success?).to be true }

      it { expect(result.customer).not_to be nil }

      it { expect(result.order).not_to be nil }

      it { expect(result.address).not_to be nil }

      it { expect(result.items).not_to be nil }

      it { expect(result.payments).not_to be nil }
    end
  end

  def customer
    {
      external_code: data[:customer_data][:external_code],
      name: 'Test',
      email: 'john@doe.com',
      contact: '41999999999'
    }
  end

  def item
    {
      external_code: data[:items_data].first[:external_code],
      name: 'Test',
      price: 49.9
    }
  end
end
