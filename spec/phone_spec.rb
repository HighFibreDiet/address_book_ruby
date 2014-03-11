require 'rspec'
require 'phone'

describe Phone do
  describe 'initialize' do
    it 'initializes the email with the email address and type' do
      test_phone = Phone.new("1234567890", "work")
      test_phone.should be_an_instance_of Phone
      test_phone.phone.should eq "1234567890"
    end
  end


end
