require 'spec_helper'

RSpec.describe IntegrationOrderOperation do
  let(:operation) { described_class }
  let(:result) { operation.call(data) }
  let(:data) {
    {
      customer_data: customer,
      order_data: order,
      address_data: address,
      items_data: items,
      payments_data: payments
    }
  }

  describe 'integration with delivery center api' do
    around(:each) do |example|
      VCR.use_cassette(cassette) do
        example.run
      end
    end

    context 'when success' do
      let!(:payload) { JSON.parse(SpecSupport.load_payload('payload_order_parse.json'), symbolize_names: true) }
      let(:cassette) { 'create_order' }

      it { expect(result.success?).to be true }
    end

    context 'when failure' do
      let!(:payload) { JSON.parse(SpecSupport.load_payload('payload_order_parse_invalid.json'), symbolize_names: true) }
      let(:cassette) { 'create_order_invalid' }

      it { expect(result.success?).to be false }

      it { expect(result.error).not_to be nil }
    end
  end

  def customer
    payload.slice(:customer)[:customer]
  end

  def order
    payload.slice(:externalCode, :storeId, :subTotal, :deliveryFee, :total_shipping, :total, :dtOrderCreate)
  end

  def address
    payload.slice(:country, :state, :city, :district, :street, :complement, :latitude, :longitude, :postalCode, :number)
  end

  def items
    payload.slice(:items)[:items]
  end

  def payments
    payload.slice(:payments)[:payments]
  end
end
