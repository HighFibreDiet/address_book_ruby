class Contact
  @@all_contacts =[]
  @@names=[]

  attr_reader :name, :phone, :email, :address

  def initialize(name, phone, email, address)
    @name = name
    @phone = phone
    @email = email
    @address = address
  end

  def Contact.all
    @@all_contacts
  end

  def save
    @@all_contacts << self
  end

  def Contact.remove(contact_to_delete)
    @@all_contacts.delete_if{|contact| contact == contact_to_delete}
  end

  def Contact.clear
    @@all_contacts = []
  end

  def Contact.create(name, phone, email, address)
    new_contact = Contact.new(name, phone, email, address)
    @@all_contacts << new_contact
    new_contact
  end

  def Contact.names
    @@names = []
    Contact.all.each do |contact|
      @@names << contact.name
    end
    @@names
  end

  def Contact.find(index)
    @@all_contacts[index]
  end

  def set_name(name)
    @name = name
  end

  def set_phone(phone)
    @phone = phone
  end

  def set_email(email)
    @email = email
  end

  def set_address(address)
    @address = address
  end
end



