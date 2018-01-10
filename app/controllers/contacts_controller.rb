class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = Contact.all.order(:first_name)

    @contacts_hashes = []

    @contacts.each do |contact|

      if contact.organization

        @contact_hash = {
          id: contact.id,
          first_name: contact.first_name,
          last_name: contact.last_name,
          cell_phone: contact.cell_phone,
          office_phone: contact.office_phone,
          email: contact.email,
          organization_name: contact.organization.legal_name,
          physical_address: contact.organization.primary_building_address
        }

      else

        @contact_hash = {
          id: contact.id,
          first_name: contact.first_name,
          last_name: contact.last_name,
          cell_phone: contact.cell_phone,
          office_phone: contact.office_phone,
          email: contact.email,
          organization_name: "No Organization Information",
          physical_address: {
            street_address: "No Address Information",
            city: "",
            state: "",
            zip: ""
          }
        }

      end

    @contacts_hashes << @contact_hash

    end


  end

end
