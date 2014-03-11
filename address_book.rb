require './lib/contact'
require './lib/phone'
require './lib/email'
require './lib/address'

@current_contact


def main_menu
  puts "\n"
  puts "Press 'v' to view your list of contacts"
  puts "Press 'a' to add a new contact"
  puts "Press 'x' to exit \n"

  main_choice = gets.chomp

  case main_choice
  when 'v'
    list_contacts
  when 'a'
    add_contact
  when 'x'
    puts "Thanks for playing!"
  else
    puts "That was not a valid choice. Please choose again.\n"
    main_menu
  end
end

def list_contacts
  Contact.names.each_with_index do |name, index|
    puts "#{index+1}. #{name}"
  end
  puts "\n\n"
  puts "Enter the number of the contact to edit it"
  puts "Press 'm' to return to the main menu\n"

  contact_selection = gets.chomp

  if contact_selection == 'm'
    main_menu
  elsif contact_selection.to_i <= Contact.all.length && (/\D/ =~ contact_selection).nil?
    @current_contact = Contact.find(contact_selection.to_i - 1)
    contact_menu
  else
    puts "\nThat is not a valid choice. Please select again\n\n"
    list_contacts
  end
end

def contact_menu
  display_contact(@current_contact)

  puts "Press 'u' to update this contact"
  puts "Press 'r' to remove this contact"
  puts "Press 'm' to return to the main menu"

  contact_edit_selection = gets.chomp
  puts "\n"

  case contact_edit_selection
  when 'u'
    update_contact
  when 'r'
    Contact.remove(@current_contact)
    main_menu
  when 'm'
    main_menu
  else
    puts "Invalid choice. Please choose again."
    contact_menu
  end

end

def add_contact

  puts "\nPlease enter the name of your new contact\n"
  new_name = gets.chomp
  new_contact = Contact.create(new_name)

  main_menu
end

def update_contact
  display_contact(@current_contact)

  puts "Press 'n' to change contact name"
  puts "Press 'a' to add new contact information to an existing contact"
  puts "Press 'e' to edit existing contact information"
  puts "Press 'c' to go back to the contact menu"
  puts "Press 'm' to return to the main menu"

  update_contact_choice=gets.chomp

  case update_contact_choice
  when 'n'
    puts "Enter the new name:"
    new_name = gets.chomp
    @current_contact.name = new_name
    update_contact
  when 'a'
    add_new_attribute
  when 'e'
    edit_attribute
  when 'c'
    contact_menu
  when 'm'
    main_menu
  else
    puts "Invalid selection.  Please choose again."
  end
end

def add_new_attribute
  display_contact(@current_contact)
  puts "Press 'p' to add a new phone"
  puts "Press 'e' to add a new email"
  puts "Press 'a' to add a new address"
  puts "Press 'c' to go back to the update contact menu"

  user_choice = gets.chomp
  case user_choice
    when 'p'
      add_phone(@current_contact)
    when 'e'
      add_email(@current_contact)
    when 'a'
      add_address(@current_contact)
    when 'c'
      update_contact
    else
      puts "Invalid selection.  Please try again."
      add_new_attribute
  end
end

def add_phone(contact)
  puts "Enter the phone number to add"
  new_phone = gets.chomp

  puts "Enter the type of phone number (home, work, or cell)"
  new_phone_type = gets.chomp
  contact.phones << Phone.new(new_phone, new_phone_type)

  valid_input = false
  until valid_input
    puts "Press 'c' to return to the update contact menu or 'n' to add another phone_number"
    user_choice = gets.chomp

    case user_choice
    when 'c'
      update_contact
      valid_input = true
    when 'n'
      add_phone(contact)
      valid_input = true
    else
      puts "Invalid choice. Please choose again."
    end
  end
end

def add_email(contact)
  puts "Enter the email to add"
  new_email = gets.chomp

  puts "Enter the type of email (home, work)"
  new_email_type = gets.chomp
  contact.emails << Email.new(new_email, new_email_type)

  valid_input = false
  until valid_input
    puts "Press 'c' to return to the update contact menu or 'n' to add another email"
    user_choice = gets.chomp

    case user_choice
    when 'c'
      update_contact
      valid_input = true
    when 'n'
      add_email(contact)
      valid_input = true
    else
      puts "Invalid choice. Please choose again."
    end
  end
end

def add_address(contact)
  puts "Enter the street address to add"
  new_street = gets.chomp

  puts "Enter the city to add"
  new_city = gets.chomp

  puts "Enter the state to add"
  new_state = gets.chomp

  puts "Enter the zip to add"
  new_zip = gets.chomp

  puts "Enter the type of address (home, work)"
  new_address_type = gets.chomp
  contact.addresses << Address.new(new_street, new_city, new_state, new_zip, new_address_type)

  valid_input = false
  until valid_input
    puts "Press 'c' to return to the update contact menu or 'n' to add another address"
    user_choice = gets.chomp

    case user_choice
    when 'c'
      update_contact
      valid_input = true
    when 'n'
      add_address(contact)
      valid_input = true
    else
      puts "Invalid choice. Please choose again."
    end
  end
end

def edit_attribute
  display_contact(@current_contact)

  puts "Press 'p' to edit a phone"
  puts "Press 'e' to edit an email"
  puts "Press 'a' to edit an address"
  puts "Press 'c' to go back to the update contact menu"

  user_choice = gets.chomp

  case user_choice
  when 'p'
    list_phones
  when 'e'
    list_emails
  when 'a'
    list_addresses
  when 'c'
    update_contact
  else
    puts "Invalid selection.  Please try again."
    edit_attribute
  end
end

def display_contact(contact)
  puts "Contact: #{contact.name}\n"

  if contact.phones.length != 0
    puts "\n"
    contact.phones.each do |phone|
      puts "#{phone.type}: #{phone.phone}"
    end
  end

  if contact.emails.length != 0
    puts "\n"
    contact.emails.each do |email|
      puts "#{email.type}: #{email.email}"
    end
  end

  if contact.addresses.length != 0
    puts "\n"
    contact.addresses.each do |address|
      puts "#{address.type}: #{address.street}"
      puts "#{address.city}, #{address.state} #{address.zip}"
    end
  end
end

def list_phones
  display_contact(@current_contact)

  @current_contact.phones.each_with_index do |phone, index|
    puts "#{index+1}. #{phone.type}: #{phone.phone}"
  end
  puts "\n\n"
  puts "Enter the number of the phone to edit it"
  puts "Press 'e' to return to the edit attribute menu\n"

  user_choice = gets.chomp

  if user_choice == 'e'
    edit_attribute
  elsif user_choice.to_i <= @current_contact.phones.length && (/\D/ =~ user_choice).nil?
    edit_phone(user_choice.to_i-1)
  else
    puts "\nThat is not a valid choice. Please select again\n\n"
    list_phones
  end
end

def list_emails
  display_contact(@current_contact)

  @current_contact.emails.each_with_index do |email, index|
    puts "#{index+1}. #{email.type}: #{email.email}"
  end
  puts "\n\n"
  puts "Enter the number of the email to edit it"
  puts "Press 'e' to return to the edit attribute menu\n"

  user_choice = gets.chomp

  if user_choice == 'e'
    edit_attribute
  elsif user_choice.to_i <= @current_contact.emails.length && (/\D/ =~ user_choice).nil?
    edit_email(user_choice.to_i - 1)
  else
    puts "\nThat is not a valid choice. Please select again\n\n"
    list_emails
  end
end

def list_addresses
  display_contact(@current_contact)

  @current_contact.addresses.each_with_index do |address, index|
    puts "#{index+1}. #{address.type}: #{address.street}, #{address.city}, #{address.state} #{address.zip}"
  end
  puts "\n\n"
  puts "Enter the number of the address to edit it"
  puts "Press 'e' to return to the edit attribute menu\n"

  user_choice = gets.chomp

  if user_choice == 'e'
    edit_attribute
  elsif user_choice.to_i <= @current_contact.addresses.length && (/\D/ =~ user_choice).nil?
    edit_address(user_choice.to_i-1)
  else
    puts "\nThat is not a valid choice. Please select again\n\n"
    list_addresses
  end
end

def edit_phone(index)

  puts "Enter the updated phone number to edit"
  puts "Or press 'r' to remove"
  new_phone=gets.chomp
  if new_phone == 'r'
    @current_contact.phones.delete_at(index)
  else
    @current_contact.phones[user_choice.to_i - 1].phone=new_phone
    puts "Number changed."
  end
  list_phones
end

def edit_email(index)

  puts "Enter the updated email to edit"
  puts "Or press 'r' to remove"
  new_email=gets.chomp
  if new_email == 'r'
    @current_contact.emails.delete_at(index)
  else
    @current_contact.emails[user_choice.to_i - 1].email=new_email
    puts "Email changed."
  end
  list_emails
end

def edit_address(index)
  puts "Press 'u' to update"
  puts "Or press 'r' to remove"
  user_choice=gets.chomp
  if user_choice == 'r'
    @current_contact.addresses.delete_at(index)
  else
    puts "Enter street address:"
    new_street_address=gets.chomp
    puts "Enter city:"
    new_city=gets.chomp
    puts "Enter state:"
    new_state=gets.chomp
    puts "Enter zip:"
    new_zip=gets.chomp
    @current_contact.addresses[user_choice.to_i - 1].street=new_street_address
    @current_contact.addresses[user_choice.to_i - 1].city=new_city
    @current_contact.addresses[user_choice.to_i - 1].state=new_state
    @current_contact.addresses[user_choice.to_i - 1].zip=new_zip
    puts "Address changed."
  end
  list_addresses
end
main_menu
