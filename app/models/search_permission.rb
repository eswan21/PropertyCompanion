class SearchPermission < ApplicationRecord
  belongs_to :search
  belongs_to :user

  validates :user_id, uniqueness: { scope: :search_id }
end
