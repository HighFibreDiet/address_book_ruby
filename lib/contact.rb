class Contact
  @@all_contacts =[]
  @@names=[]

  attr_accessor :name, :phones, :emails, :addresses

  def initialize(name)
    @name = name
    @addresses = []
    @phones = []
    @emails = []
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

  def Contact.create(name)
    new_contact = Contact.new(name)
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

end




