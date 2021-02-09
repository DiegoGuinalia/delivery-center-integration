require 'spec_helper'

describe Item, type: :model do
  context 'includes' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  context 'fields types' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:price).of_type(Float) }
    it { is_expected.to have_field(:external_code).of_type(String) }
  end

  context 'relationship' do
    it { is_expected.to have_many :order_items }
  end
end
