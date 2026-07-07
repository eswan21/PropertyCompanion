class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  has_many :searches, dependent: :destroy

  has_many :search_permissions, dependent: :destroy
  has_many :shared_searches, through: :search_permissions, source: :search
  has_many :sent_search_invitations,
         class_name: "SearchInvitation",
         foreign_key: :invited_by_id,
         dependent: :nullify

  def self.from_google(auth)
    user = find_or_initialize_by(email: auth.info.email)

    if user.new_record?
      user.name = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token.first(20)
      user.skip_confirmation!
    end

    user.save!
    user
  end
end
