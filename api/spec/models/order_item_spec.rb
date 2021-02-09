require 'spec_helper'

describe OrderItem, type: :model do
  context 'includes' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  context 'fields types' do
    it { is_expected.to have_field(:quantity).of_type(Integer) }
    it { is_expected.to have_field(:total).of_type(Float) }
  end

  context 'relationship' do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :item }
  end
end
