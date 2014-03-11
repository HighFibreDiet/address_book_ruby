require 'rspec'
require 'contact'

describe Contact do
  before do
    Contact.clear
  end

  describe '.all' do
    it 'is empty at first' do
      Contact.all.should eq []
    end
  end

  describe '#save' do
    it 'moves a contact to the all contacts array' do
      test_contact = Contact.new("Susie Smith", "434-454-3424", "email@internet.com", "123 main st")
      test_contact.save
      Contact.all.should eq [test_contact]
    end
  end

  describe '.clear' do
    it 'empties out the all_contacts array' do
      Contact.new("Susie Smith", "434-454-3424", "email@internet.com", "123 main st").save
      Contact.clear
      Contact.all.should eq []
    end
  end

  describe '.create' do
    it 'create an instance of the Contact class' do
      test_contact = Contact.create("Susie Smith", "434-454-3424", "email@internet.com", "123 main st")
      test_contact.should be_an_instance_of Contact
    end
    it 'push the new contact to the all contacts array' do
      test_contact = Contact.create("Susie Smith", "434-454-3424", "email@internet.com", "123 main st")
      Contact.all.should eq [test_contact]
    end
  end

  describe 'initialize' do
    it 'creates a contact object and sets the name property' do
      test_contact = Contact.new("Susie Smith", "434-454-3424", "email@internet.com", "123 main st")
      test_contact.should be_an_instance_of Contact
    end
    it 'creates a contact object and sets the name property' do
      test_contact = Contact.new("Susie Smith", "434-454-3424", "email@internet.com", "123 main st")
      test_contact.name.should eq "Susie Smith"
    end
  end

  describe '.names' do
    it 'lists all of the names in all contacts' do
      test_contact=Contact.create("Susie Smith", "434-454-3424", "email@internet.com", "123 main st")
      Contact.names.should eq ["Susie Smith"]
    end
  end

  describe '.find' do
    it 'returns the contact object from all_contacts' do
      test_contact=Contact.create("Susie Smith", "434-454-3424", "email@internet.com", "123 main st")
      Contact.find(0).should eq test_contact
    end
  end

   describe '.remove' do
    it 'removes the given contact from the all_contacts array' do
      test_contact=Contact.create("Susie Smith", "434-454-3424", "email@internet.com", "123 main st")
      test_contact2 = Contact.create("Sarah Smith", "434-454-3424", "other_email@internet.com", "123 main st")
      Contact.remove(test_contact)
      Contact.all.should eq [test_contact2]
    end
  end
end

