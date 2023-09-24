class User
  attr_reader :first_name, :last_name, :email, :tokens

  # Initialize a new User
  def initialize(id:, first_name:, last_name:, email:, tokens:, active_status:, company_id:, email_status:)
    raise ArgumentError, "ID is invalid" unless id.is_a?(Integer)
    raise ArgumentError, "First Name is missing" if first_name.empty?
    raise ArgumentError, "Last Name is missing" if last_name.empty?
    raise ArgumentError, "Email is missing" if email.empty?
    raise ArgumentError, "Tokens amount is invalid" unless tokens.is_a?(Integer)
    raise ArgumentError, "Active status is invalid" unless active_status.is_a?(TrueClass) \
                                                        || active_status.is_a?(FalseClass)
    raise ArgumentError, "Email status is invalid" unless email_status.is_a?(TrueClass) \
                                                       || email_status.is_a?(FalseClass)

    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @tokens = tokens
    @active_status = active_status
    @company_id = company_id
    @email_status = email_status
  end

  # Checks if user is active for the given company
  def active_for_company?(company)
    @active_status && @company_id == company.id
  end

  # Checks if user and company allow emails
  def emailable?(company)
    @email_status && company.email_status
  end

  # Tops up user's tokens
  def top_up(amount)
    @tokens += amount
  end
end
