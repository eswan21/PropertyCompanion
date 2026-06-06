class Property < ApplicationRecord
  belongs_to :search

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
    order(Arel.sql("personal_priority ASC NULLS LAST"))
  }
end
