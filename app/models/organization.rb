class Organization < ApplicationRecord
  has_many :buildings
  has_many :roles
  has_many :security_contracts, through: :buildings

  def primary_building_address
    primary_building = Building.where({ primary_building: "Yes", organization_id: self.id})[0]
    primary_building_address = ""

    if primary_building
      primary_building_address = {
       street_address: primary_building.street_address,
       city: primary_building.city,
       state: primary_building.state,
       zip: primary_building.zip
      }
    else
      primary_building_address = {
        street_address: "No Address Information",
        city: "",
        state: "",
        zip: ""
      }
    end
    primary_building_address
  end
end
