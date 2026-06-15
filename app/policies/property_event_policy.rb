class PropertyEventPolicy < ApplicationPolicy
  def create?
    owner? || collaborator?
  end

  private

  def owner?
    record.property.search.user == user
  end

  def collaborator?
    record.property.search.search_permissions.exists?(user: user)
  end
end
