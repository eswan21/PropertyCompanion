class Avo::Resources::SearchInvitation < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :search, as: :belongs_to
    field :invited_by, as: :belongs_to
    field :email, as: :text
    field :token, as: :text
    field :accepted_at, as: :date_time
    field :expires_at, as: :date_time
  end
end
