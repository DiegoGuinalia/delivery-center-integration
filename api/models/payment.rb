# frozen_string_literal: true

class Payment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :order

  field :type, type: String
  field :value, type: Float
end
