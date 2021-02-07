class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :order_items

  field :name, type: String
  field :price, type: Float
  field :external_code, type: String
end
