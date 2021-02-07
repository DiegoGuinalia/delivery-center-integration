class OrderContract < Dry::Validation::Contract
  params do
    required(:email).value(:string)
    required(:externalCode).value(:string)
  end

  rule(:email) do
    validate_format_email(value, key)
  end

  def validate_format_email(value, key)
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('email invalid format')
    end
  end
end
