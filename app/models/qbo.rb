class Qbo < ApplicationRecord
  attr_encrypted :access_token, iv: SecureRandom.random_bytes(12), key: ENV["SECRET_KEY_BASE"]
  attr_encrypted :refresh_token, iv: SecureRandom.random_bytes(12), key: ENV["SECRET_KEY_BASE"]
  attr_encrypted :realm_id, iv: SecureRandom.random_bytes(12), key: ENV["SECRET_KEY_BASE"]
end
