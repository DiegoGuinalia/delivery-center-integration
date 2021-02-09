# frozen_string_literal: true

class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :order
  belongs_to :item

  field :quantity, type: Integer
  field :total, type: Float
end
