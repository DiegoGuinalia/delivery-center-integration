class OrderDataContract < Dry::Validation::Contract
  params do
    required(:id).value(:integer)
    required(:store_id).value(:integer)
    required(:total_amount).value(:float)
    required(:total_shipping).value(:float)
    required(:email).value(:string)

    required(:shipping).schema do
      required(:receiver_address).schema do
        required(:country).schema do
          required(:id).value(:string)
        end

        required(:state).schema do
          required(:name).value(:string)
        end

        required(:city).schema do
          required(:name).value(:string)
        end

        required(:neighborhood).schema do
          required(:name).value(:string)
        end

        required(:street_name).value(:string)

        required(:comment).value(:string)

        required(:zip_code).value(:string)

        required(:street_number).value(:string)

        required(:latitude).value(:float)

        required(:longitude).value(:float)
      end
    end
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('email invalid format')
    end
  end

  rule(:state) do
    rule(:name) do
      key.failure('state invalid') unless AddressParse::STATE_OPTIONS.include? :"#{value}"
    end
  end
end
