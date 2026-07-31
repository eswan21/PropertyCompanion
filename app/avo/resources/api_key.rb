class Avo::Resources::ApiKey < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :token_digest, as: :text
    field :active, as: :boolean
    field :last_used_at, as: :date_time
  end
end
