module SpecSupport
  def self.load_payload
    payload = File.open("#{Dir.pwd}/spec/support/payload.json")
    JSON.load(payload)
  end
end
