class PropertyPolicy < ApplicationPolicy
  def show?
    owner? || collaborator?
  end

  def create?
    owner? || collaborator?
  end

  def update?
    owner? || collaborator?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.search.user == user
  end

  def collaborator?
    record.search.search_permissions.exists?(user: user)
  end
end
