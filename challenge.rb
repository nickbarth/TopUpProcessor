#!/usr/bin/env ruby

require "json"
require_relative "lib/company"
require_relative "lib/user"

class Challenge
  # Main processing method
  def self.process(companies_file, users_file)
    # Parse company and user data from JSON files and build respective objects.
    companies = parse_json(companies_file).map { |c| build_company(c) }
    users = parse_json(users_file).map { |u| build_user(u) }

    output = []

    # Iterate through each company, sorted by id.
    companies.sort_by { |c| c.id }.each do |company|
      # Select and sort users to be emailed for the current company.
      emailed_users = users.select { |u| u.active_for_company?(company) && u.emailable?(company) }
      emailed_users.sort_by! { |u| [u.last_name, u.first_name] }

      # Select and sort users not to be emailed for the current company.
      not_emailed_users = users.select { |u| u.active_for_company?(company) && !u.emailable?(company) }
      not_emailed_users.sort_by! { |u| [u.last_name, u.first_name] }

      # Process each company and append the output.
      output += process_company(company, emailed_users, not_emailed_users)
    end

    # Append newline at the end of the output.
    output << ""

    # Write the final output to 'output.txt'.
    File.open("output.txt", "w") do |file|
      output.each { |line| file.puts(line) }
    end
  end

  # Build a Company object from parsed JSON data.
  def self.build_company(company)
    Company.new(
      id: company["id"],
      name: company["name"],
      top_up: company["top_up"],
      email_status: company["email_status"]
    )
  end

  # Build a User object from parsed JSON data.
  def self.build_user(user)
    User.new(
      id: user["id"],
      first_name: user["first_name"],
      last_name: user["last_name"],
      email: user["email"],
      tokens: user["tokens"],
      active_status: user["active_status"],
      company_id: user["company_id"],
      email_status: user["email_status"]
    )
  end

  # Process each company, generating the output for emailed and not emailed users.
  def self.process_company(company, emailed_users, not_emailed_users)
    output = []

    # Append newline to separate each company.
    output << ""

    # Append company details to the output.
    output << "\tCompany Id: #{company.id}"
    output << "\tCompany Name: #{company.name}"

    # Append details for users who were emailed.
    output << "\tUsers Emailed:"
    emailed_users.each do |user|
      user_previous_tokens = user.tokens
      company.process_user(user)
      output << "\t\t#{user.last_name}, #{user.first_name}, #{user.email}"
      output << "\t\t  Previous Token Balance, #{user_previous_tokens}"
      output << "\t\t  New Token Balance #{user.tokens}"
    end

    # Append details for users who were not emailed.
    output << "\tUsers Not Emailed:"
    not_emailed_users.each do |user|
      user_previous_tokens = user.tokens
      company.process_user(user)
      output << "\t\t#{user.last_name}, #{user.first_name}, #{user.email}"
      output << "\t\t  Previous Token Balance, #{user_previous_tokens}"
      output << "\t\t  New Token Balance #{user.tokens}"
    end

    # Append total top-ups for the company.
    output << "\t\tTotal amount of top ups for #{company.name}: #{company.total_top_up}"

    # Only return the output if the company has been topped up.
    company.total_top_up.zero? ? [] : output
  end

  # Parse JSON file and return the data, or raise an error if parsing fails.
  def self.parse_json(filename)
    JSON.parse(File.read(filename))
  rescue JSON::ParserError => e
    raise "Error parsing JSON from #{filename}: #{e.message}"
  end
end

# Execute the process method with the specified JSON files as arguments.
if __FILE__ == $0
  Challenge.process("companies.json", "users.json")
end
