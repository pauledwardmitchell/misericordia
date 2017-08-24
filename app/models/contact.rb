class Contact < ApplicationRecord
  has_one :role
  has_one :organization, through: :role
end
