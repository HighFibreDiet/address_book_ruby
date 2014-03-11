require 'rspec'
require 'email'

describe Email do
  describe 'initialize' do
    it 'initializes the email instance with the email and type' do
      test_email = Email.new("test@test.com", "work")
      test_email.should be_an_instance_of Email
      test_email.email.should eq "test@test.com"
    end
  end


end
