require_relative "lib/company"
require_relative "lib/user"

module Processor
  class Error < StandardError; end

  def self.process(companies_file, users_file)
    puts "Hello world!"
  end
end

if __FILE__ == $0
  Processor.process("companies.json", "users.json")
end
