class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :searches, dependent: :destroy

  has_many :search_permissions, dependent: :destroy
  has_many :shared_searches, through: :search_permissions, source: :search
  has_many :sent_search_invitations,
         class_name: "SearchInvitation",
         foreign_key: :invited_by_id,
         dependent: :nullify
end
