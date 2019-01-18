class DataEncryptingKey < ActiveRecord::Base

  attr_encrypted :key,
                 key: :key_encrypting_key

  validates :key, presence: true

  has_many :encrypted_strings

  def self.primary
    find_by(primary: true)
  end

  def self.generate!(attrs={})
    create!(attrs.merge(key: AES.key))
  end

  def key_encrypting_key
    SecureRandom.random_bytes(32)
  end
end

