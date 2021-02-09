# frozen_string_literal: true

module SpecSupport
  def self.load_payload(name)
    payload = File.open("#{Dir.pwd}/spec/support/#{name}")
    JSON.load(payload)
  end
end
