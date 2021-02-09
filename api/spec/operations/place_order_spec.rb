# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PlaceOrder do
  let(:operation) { described_class }
  let(:result) { operation.call(params: payload) }
  let!(:operations) { [OrderParsingDataOperation, IntegrationOrderOperation, CreateOrderOperation] }

  describe 'operations in organizer' do
    it { expect(operation.organized).to eq(operations) }
  end

  describe 'call' do
    around(:each) do |example|
      VCR.use_cassette(cassette) do
        example.run
      end
    end

    context 'when success' do
      let(:payload) { JSON.parse(SpecSupport.load_payload('payload_valid.json'), symbolize_names: true) }
      let(:cassette) { 'create_order' }

      it { expect(result.success?).to be true }
    end

    context 'when failure' do
      let(:payload) { JSON.parse(SpecSupport.load_payload('payload_invalid.json'), symbolize_names: true) }
      let(:cassette) { 'create_order_invalid' }

      it { expect(result.success?).to be false }

      it { expect(result.error).not_to be nil }
    end
  end
end
