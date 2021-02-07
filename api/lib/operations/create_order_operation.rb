class CreateOrderOperation
  include Interactor

  delegate :params, to: :context

  def call
    require 'pry'; binding.pry
  end
end
