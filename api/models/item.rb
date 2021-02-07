class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: Float
  field :external_code, type: BigDecimal
end