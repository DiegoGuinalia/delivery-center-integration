class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :order

  field :country, type: String
  field :city, type: String
  field :district, type: String
  field :street, type: String
  field :complement, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  field :postal_code, type: String
  field :number, type: String
end