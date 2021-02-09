# frozen_string_literal: true

class CustomerParser
  def initialize(params)
    @params = params[:buyer]
  end

  def parse_customer
    {
      external_code: @params[:id],
      name: @params[:nickname],
      email: @params[:email],
      contact: @params[:phone][:area_code].to_s + @params[:phone][:number]
    }
  end
end
