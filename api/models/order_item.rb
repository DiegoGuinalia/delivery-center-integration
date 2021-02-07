class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :order
  belongs_to :item

  field :quantity, type: String
  field :total, type: Float
end