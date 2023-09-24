class Company
  attr_reader :id, :name, :total_top_up, :email_status

  # Initialize a new Company
  def initialize(id:, name:, top_up:, email_status:)
    raise ArgumentError, "ID is invalid" unless id.is_a?(Integer)
    raise ArgumentError, "Name is missing" if name.empty?
    raise ArgumentError, "Top up amount is invalid" unless top_up.is_a?(Integer)
    raise ArgumentError, "Email status is invalid" unless email_status.is_a?(TrueClass) \
                                                       || email_status.is_a?(FalseClass)

    @id = id
    @name = name
    @top_up = top_up
    @email_status = email_status
    @total_top_up = 0
  end

  # Processes a user, tops up their tokens if active and associated with the company
  def process_user(user)
    return unless user.active_for_company?(self)
    user.top_up(@top_up)
    @total_top_up += @top_up
  end
end
