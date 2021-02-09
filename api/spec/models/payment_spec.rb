require 'spec_helper'

describe Payment, type: :model do
  context 'includes' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  context 'fields types' do
    it { is_expected.to have_field(:type).of_type(String) }
    it { is_expected.to have_field(:value).of_type(Float) }
  end

  context 'relationship' do
    it { is_expected.to belong_to :order }
  end
end
