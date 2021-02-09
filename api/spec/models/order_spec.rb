# frozen_string_literal: true

require 'spec_helper'

describe Order, type: :model do
  context 'includes' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  context 'fields types' do
    it { is_expected.to have_field(:store_id).of_type(Integer) }
    it { is_expected.to have_field(:sub_total).of_type(Float) }
    it { is_expected.to have_field(:delivery_fee).of_type(Float) }
    it { is_expected.to have_field(:total_shipping).of_type(Float) }
    it { is_expected.to have_field(:total).of_type(Float) }
    it { is_expected.to have_field(:external_code).of_type(BigDecimal) }
  end

  context 'relationship' do
    it { is_expected.to have_one :address }
    it { is_expected.to have_many :order_items }
    it { is_expected.to have_many :payments }
    it { is_expected.to belong_to :customer }
  end
end
