class Phone
  attr_accessor :phone, :type

  def initialize(phone, type = "home")
    @phone = phone
    @type = type
  end
end
