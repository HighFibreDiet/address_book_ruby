class Address

  attr_accessor :street, :city, :state, :zip, :type

  def initialize(street, city, state, zip, type)
    @street = street
    @city = city
    @state = state
    @zip = zip
    @type = type
  end

end
