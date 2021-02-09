# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Parse order request', type: :request do
  let(:stub) { double('interactor') }
  let(:response) { post '/api/v1/orders/parse_order' }
  let(:response_body) { JSON.parse(response.body, symbolize_names: true) }

  describe 'POST #parse_order' do
    before do
      allow(PlaceOrder).to receive(:call) { stub }
      allow(stub).to receive(:success?) { status }
      allow(stub).to receive(:error) { error }
    end

    context 'when payload is correct' do
      let(:status) { true }
      let(:error) { nil }

      it { expect(response.status).to eq(200) }

      it { expect(response_body[:result]).to eq('success') }
    end

    context 'when payload is incorrect' do
      let(:status) { false }
      let(:error) { { msg: 'test' } }

      it { expect(response.status).to eq(422) }

      it { expect(response_body[:result]).to eq('failed') }

      it { expect(response_body[:error]).not_to be nil }
    end
  end
end
