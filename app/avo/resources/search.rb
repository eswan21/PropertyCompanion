class Avo::Resources::Search < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :user_id, as: :number
    field :user, as: :belongs_to
    field :properties, as: :has_many
    field :search_permissions, as: :has_many
    field :shared_users, as: :has_many, through: :search_permissions
  end
end
