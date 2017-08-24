# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)





# # # LOAD CONTACTS (STEP #1)
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

# # # LOAD (STEP #2)

# security_vendors_records = File.read('db/data/SecurityVendor.json')
# puts "File read"

# security_vendors_hash = JSON.parse(security_vendors_records)
# puts "Hash made"

# security_vendors_hash.each do |vendor|

#   new_security_vendor = SecurityVendor.create(name: vendor["VendorName"])

# end

# # # LOAD ORGANIZATIONS (STEP 3)

# organizations_records = File.read('db/data/Organization.json')
# puts "File read"

# organizations_hash = JSON.parse(organizations_records)
# puts "Hash made"
# binding.pry
# organizations_hash.each do |organization|
#   loop do
#     new_organization = Organization.create(
#                                           og_id: organization["id"],
#                                           legal_name: organization["LegalName"],
#                                           common_name: organization["CommonName"]
#                                           )

#     if new_organization.id == organization["id"]
#       puts "Organization made! " + organization["LegalName"] + ": " + organization["id"].to_s
#       # if contact["Notes"] && contact["Notes"].length > 0
#       #   Note.create(contact_id: contact["id"], text: contact["Notes"])
#       # end
#       break
#     else
#       new_organization.delete
#     end
#   end
# end

# # #LOAD BUILDINGS (STEP 4)

# buildings_records = File.read('db/data/Building.json')
# puts "File read"

# buildings_hash = JSON.parse(buildings_records)
# puts "Hash made"

# buildings_hash.each do |building|
#   loop do
#     new_building = Building.create(og_id: building["id"],
#                                    primary_building: building["PrimaryBuilding"],
#                                    street_address: building["Address"],
#                                    city: building["City"],
#                                    state: building["State"],
#                                    zip: building["Zip"],
#                                    square_footage: building["SqFootage"],
#                                    organization_id: building["Organization_id"]
#                                   )
#     if new_building.id == building["id"]
#       puts "Building made! " + building["Address"] + ": " + building["id"].to_s

#       break
#     else
#       new_building.delete
#     end
#   end
# end

# # LOAD ROLES (STEP #5)
# roles_records = File.read('db/data/OrganizationContact.json')
# puts "File read"

# roles_hash = JSON.parse(roles_records)
# puts "Hash made"

# roles_hash.each do |role|
#   loop do
#     new_role = Role.create(og_id: role["id"],
#                            organization_id: role["Organization_id"],
#                            contact_id: role["Contact_id"],
#                            role: role["Role"],
#                            committee_name: role["CommitteeName"],
#                            date_noted: role["DateNoted"],
#                            date_term_ends: role["DateTermEnds"]
#                            )

#     if new_role.id == role["id"]
#       puts "Role made! " + role["Role"] + ": " + role["id"].to_s

#       break
#     else
#       new_role.delete
#     end
#   end
# end
