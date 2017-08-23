# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)









# LOAD CONTACTS (STEP #1)
# contacts_records = File.read('db/data/Contact.json')
# puts "File read"

# contacts_hash = JSON.parse(contacts_records)
# puts "Hash made"

# contacts_hash.each do |contact|
#   loop do
#     new_contact = Contact.create(og_id: contact["id"],
#                               salutation: contact["Salutation"],
#                               first_name: contact["FirstName"],
#                               last_name: contact["LastName"],
#                               level: contact["Level"],
#                               email: contact["Email"],
#                               frequency: contact["Frequency"],
#                               cell_phone: contact["CellPhone"],
#                               office_phone: contact["OfficePhone"],
#                               fax: contact["Fax"],
#                               date_of_contact: contact["DateOfContact"],
#                               cpa_contact: contact["CPAContact"]
#                               )

#     if new_contact.id == contact["id"]
#       puts "Contact made! " + contact["LastName"] + ": " + contact["id"].to_s
#       if contact["Notes"] && contact["Notes"].length > 0
#         Note.create(contact_id: contact["id"], text: contact["Notes"])
#       end

#       break
#     else
#       new_contact.delete
#     end
#   end
# end

# LOAD (STEP #2)

# security_vendors_records = File.read('db/data/SecurityVendor.json')
# puts "File read"

# security_vendors_hash = JSON.parse(security_vendors_records)
# puts "Hash made"

# security_vendors_hash.each do |vendor|

#   new_security_vendor = SecurityVendor.create(name: vendor["VendorName"])

# end
