class PlaceOrder
  include Interactor::Organizer

  organize OrderParsingDataOperation, CreateOrderOperation
end
