# frozen_string_literal: true
module Worker
  # Only for test sidekiq
  class Checker
    include Sidekiq::Worker
    sidekiq_options queue: :checker
    def perform
      msg = "#{Time.now} - Sidekiq working... \n"
      dir = "#{Dir.pwd}/storage/sidekiq_test.txt"
      File.write(dir, msg, mode: 'a')
    end
  end
end