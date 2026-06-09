class Property < ApplicationRecord
  belongs_to :search, touch: true
  has_many :property_events, dependent: :destroy

  def viewed?
    property_events.exists?(event_type: "viewed")
  end

  validates :title, presence: true

  validates :council_tax_band,
            inclusion: {
              in: %w[A B C D E F G H]
            },
            allow_blank: true

  validates :epc_rating,
            inclusion: {
              in: %w[A B C D E F G]
            },
            allow_blank: true

  scope :by_priority, -> {
    order(open: :desc)
      .order(Arel.sql("personal_priority ASC NULLS LAST"))
  }
end
