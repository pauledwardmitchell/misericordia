class Role < ApplicationRecord
  belongs_to :contact
  belongs_to :organization
end
