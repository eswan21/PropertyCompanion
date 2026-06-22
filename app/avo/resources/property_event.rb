class Avo::Resources::PropertyEvent < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :property_id, as: :number
    field :event_type, as: :text
    field :note, as: :textarea
    field :created_by_id, as: :number
    field :property, as: :belongs_to
    field :creator, as: :belongs_to
  end
end
