class Building < ApplicationRecord
  belongs_to :organization
  has_one :security_contract
end
