# frozen_string_literal: true

require 'spec_helper'

describe Address, type: :model do
  context 'includes' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  context 'fields types' do
    it { is_expected.to have_field(:country).of_type(String) }
    it { is_expected.to have_field(:state).of_type(String) }
    it { is_expected.to have_field(:city).of_type(String) }
    it { is_expected.to have_field(:district).of_type(String) }
    it { is_expected.to have_field(:street).of_type(String) }
    it { is_expected.to have_field(:complement).of_type(String) }
    it { is_expected.to have_field(:latitude).of_type(Float) }
    it { is_expected.to have_field(:longitude).of_type(Float) }
    it { is_expected.to have_field(:postal_code).of_type(String) }
    it { is_expected.to have_field(:number).of_type(String) }
  end

  context 'relationship' do
    it { is_expected.to belong_to :order }
  end
end
