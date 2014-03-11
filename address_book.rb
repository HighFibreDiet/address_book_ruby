require './lib/contact'

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
  puts "Name: #{@current_contact.name} \nPhone: #{@current_contact.phone} \nEmail: #{@current_contact.email} \nAddress: #{@current_contact.address} \n \n"

  puts "Press 'u' to update this contact"
  puts "Press 'r' to remove this contact"
  puts "Press 'm' to return to the main menu"

  contact_edit_selection = gets.chomp
  puts "\n"

  case contact_edit_selection
  when 'u'
    edit_contact
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
  puts "\nPlease enter the phone of your new contact\n"
  new_phone = gets.chomp
  puts "\nPlease enter the email of your new contact\n"
  new_email = gets.chomp
  puts "\nPlease enter the address of your new contact\n"
  new_address = gets.chomp

  new_contact = Contact.create(new_name, new_phone, new_email, new_address)

  main_menu
end

def edit_contact
  puts "Name: #{@current_contact.name} \nPhone: #{@current_contact.phone} \nEmail: #{@current_contact.email} \nAddress: #{@current_contact.address} \n \n"

  puts "Press 'n' to edit the contact name"
  puts "Press 'p' to edit the contact phone number"
  puts "Press 'e' to edit the contact email"
  puts "Press 'a' to edit the contact address"
  puts "Press 'c' to go back to the contact menu"
  puts "Press 'm' to return to the main menu"

  edit_contact_choice=gets.chomp

  case edit_contact_choice
  when 'n'
    puts "Enter the new name:"
    new_name = gets.chomp
    @current_contact.set_name(new_name)
    edit_contact
  when 'p'
    puts "Enter the new phone:"
    new_phone = gets.chomp
    @current_contact.set_phone(new_phone)
    edit_contact
  when 'e'
    puts "Enter the new email:"
    new_email = gets.chomp
    @current_contact.set_email(new_email)
    edit_contact
  when 'a'
    puts "Enter the new address:"
    new_address = gets.chomp
    @current_contact.set_address(new_address)
    edit_contact
  when 'c'
    contact_menu
  when 'm'
    main_menu
  else
    puts "Invalid selection.  Please choose again."
  end
end

main_menu
