require "digest"
require "securerandom"

class ApiKey < ApplicationRecord
  KEY_PREFIX = "pc_".freeze

  validates :name, presence: true
  validates :token_digest, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }

  def self.issue!(name:)
    raw_token = "#{KEY_PREFIX}#{SecureRandom.hex(32)}"

    create!(
      name: name,
      token_digest: digest(raw_token)
    )

    raw_token
  end

  def self.digest(raw_token)
    Digest::SHA256.hexdigest(raw_token)
  end
end
