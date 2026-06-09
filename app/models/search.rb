class Search < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  has_many :properties, dependent: :destroy

  def open_properties_count
    properties.where(open: true).count
  end

  def closed_properties_count
    properties.where(open: false).count
  end
end
