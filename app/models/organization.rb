class Organization < ApplicationRecord
  has_many :buildings
  has_many :roles
end
