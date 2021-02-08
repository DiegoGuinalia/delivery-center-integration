class PlaceOrder
  include Interactor::Organizer

  organize OrderParsingDataOperation, IntegrationOrderOperation, CreateOrderOperation
end
