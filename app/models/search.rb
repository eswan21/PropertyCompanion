class Search < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  has_many :properties, dependent: :destroy
end
