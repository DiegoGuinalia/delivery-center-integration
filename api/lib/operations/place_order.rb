# frozen_string_literal: true

class PlaceOrder
  include Interactor::Organizer

  organize OrderParsingDataOperation, IntegrationOrderOperation, CreateOrderOperation
end
