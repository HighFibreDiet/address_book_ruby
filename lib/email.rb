class Email
  attr_accessor :email, :type

  def initialize(email, type)
    @email = email
    @type = type
  end
end
