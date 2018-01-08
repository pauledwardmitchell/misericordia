class Qbo < ApplicationRecord
  attr_encrypted :access_token, key: 'Encrypted Access Token'
  attr_encrypted :refresh_token, key: 'Encrypted Refresh Token'
  attr_encrypted :realm_id, key: 'Realm Id'
end
