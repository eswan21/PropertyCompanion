class SearchInvitation < ApplicationRecord
  belongs_to :search
  belongs_to :invited_by, class_name: "User"

  validates :email, presence: true
  validates :token, presence: true, uniqueness: true
  validates :email, uniqueness: { scope: :search_id }

  before_validation :generate_token, on: :create

  def expired?
    expires_at.present? && expires_at.past?
  end

  def accepted?
    accepted_at.present?
  end

  private

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64(32)
  end
end
