class OrderParse
  def initialize(params)
    @params = params
  end

  def parse_order
    {
      external_code: @params[:id],
      store_id: @params[:store_id],
      sub_total: @params[:total_amount],
      delivery_fee: @params[:total_shipping],
      total_shipping: @params[:total_shipping],
      total: @params[:total_amount_with_shipping],
      dtOrderCreate: "2019-06-27T19:59:08.251Z"
    }
  end
end
