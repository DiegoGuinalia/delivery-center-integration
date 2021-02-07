class PaymentsParser
  def initialize(params)
    @payments = params[:payments]
  end

  def parse_payments
    payments_parse = []

    @payments.each do |payment|
      payments_parse << {
        type: payment[:payment_type].upcase,
        value: payment[:total_paid_amount]
      }
    end

    payments_parse
  end
end
