class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all.order(:legal_name)

    @organizations_hashes = []

    @organizations.each do |organization|

      @organization_hash = {
        id: organization.id,
        legal_name: organization.legal_name,
        common_name: organization.common_name,
        primary_building_address: organization.primary_building_address,
        all_buildings: []
      }

      if organization.buildings.count > 1

        organization.buildings.each do |building|

          @building_address = {
           id: building.id,
           street_address: building.street_address,
           city: building.city,
           state: building.state,
           zip: building.zip
          }

          @organization_hash[:all_buildings] << @building_address
        end

      end

      @organizations_hashes << @organization_hash

    end
    # binding.pry
    @organizations_hashes
  end

end
