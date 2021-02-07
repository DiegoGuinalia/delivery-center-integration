class OrderParsingDataOperation
  # {
  #   doctor: {
  #     email: 'agosto@gmail.com',
  #     confirmation_pin: '123434'
  #   }
  # }
  include Interactor

  delegate :params, to: :context

  def call
    validate_contract
    save!
  end

  private

  def validate_contract
    require 'pry'; binding.pry
    contract = OrderDataContract.new
    contract.call(params)
  end

  def save!
  end
end
