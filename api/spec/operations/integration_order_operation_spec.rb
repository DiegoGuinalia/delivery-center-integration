require 'spec_helper'

RSpec.describe IntegrationOrderOperation do
  let(:operation) { described_class }
  let(:result) { operation.call(data) }
  let(:data) {
    {
      customer_data: PlaceOrderHelper.customer(payload),
      order_data: PlaceOrderHelper.order(payload),
      address_data: PlaceOrderHelper.address(payload),
      items_data: PlaceOrderHelper.items(payload),
      payments_data: PlaceOrderHelper.payments(payload)
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
end
