class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :orders

  field :name, type: String
  field :email, type: String
  field :contact, type: String
  field :external_code, type: BigDecimal
end