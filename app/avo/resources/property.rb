class Avo::Resources::Property < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :search_id, as: :number
    field :title, as: :text
    field :location, as: :text
    field :price_per_month, as: :number
    field :personal_priority, as: :number
    field :url, as: :text
    field :address, as: :text
    field :postcode, as: :text
    field :council_tax_band, as: :text
    field :epc_rating, as: :text
    field :disadvantages, as: :textarea
    field :notes, as: :textarea
    field :open, as: :boolean
    field :search, as: :belongs_to
    field :property_events, as: :has_many
  end
end
