class Member < ApplicationRecord
  validates :pw_id, uniqueness: true
end
