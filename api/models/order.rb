# frozen_string_literal: true

class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one :address
  has_many :order_items
  has_many :payments
  belongs_to :customer

  field :store_id, type: Integer
  field :sub_total, type: Float
  field :delivery_fee, type: Float
  field :total_shipping, type: Float
  field :total, type: Float
  field :external_code, type: BigDecimal
end
