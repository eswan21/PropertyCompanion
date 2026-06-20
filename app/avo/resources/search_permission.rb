class Avo::Resources::SearchPermission < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :search_id, as: :number
    field :user_id, as: :number
    field :search, as: :belongs_to
    field :user, as: :belongs_to
  end
end
