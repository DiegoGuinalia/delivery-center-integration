# frozen_string_literal: true

module BSON
  # Mokey patching for return json BSON::ObjectId
  class ObjectId
    def to_json(*_)
      to_s.to_json
    end

    def as_json(*_)
      to_s.as_json
    end
  end
end
