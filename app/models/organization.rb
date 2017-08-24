class Organization < ApplicationRecord
  has_many :buildings
  has_many :roles
  has_many :security_contracts, through: :buildings
end
