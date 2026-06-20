class Avo::Resources::User < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :email, as: :text
    field :name, as: :text
    field :searches, as: :has_many
    field :search_permissions, as: :has_many
    field :shared_searches, as: :has_many, through: :search_permissions
  end
end
