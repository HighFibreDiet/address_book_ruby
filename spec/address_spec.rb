require 'rspec'
require 'address'

describe Address do
  describe 'initialize' do
    it 'initializes the address instance with a street, city, state, and zip' do
      test_address = Address.new("123 main", "Portland", "OR", 97456, "home")
      test_address.should be_an_instance_of Address
      test_address.city.should eq "Portland"
    end
  end


end
