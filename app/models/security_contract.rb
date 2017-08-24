class SecurityContract < ApplicationRecord
  has_one :organization, through: :building
  belongs_to :building
  belongs_to :security_vendor
end
