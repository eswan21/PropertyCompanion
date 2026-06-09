class PropertyEvent < ApplicationRecord
  EVENT_TYPES = %w[
    viewed
    other
    close
    reopen
  ].freeze

  belongs_to :property, touch: true
  belongs_to :creator, class_name: "User", foreign_key: :created_by_id

  validates :event_type, presence: true, inclusion: { in: EVENT_TYPES }
end
