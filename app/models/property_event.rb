class PropertyEvent < ApplicationRecord
  EVENT_TYPES = %w[viewed other].freeze

  belongs_to :property
  belongs_to :creator, class_name: "User", foreign_key: :created_by_id

  validates :event_type, presence: true, inclusion: { in: EVENT_TYPES }
  validates :creator, presence: true
end
