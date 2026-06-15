class SearchPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      Search
        .left_joins(:search_permissions)
        .where(
          "searches.user_id = :user_id OR search_permissions.user_id = :user_id",
          user_id: user.id
        )
        .distinct
    end
  end

  def show?
    owner? || collaborator?
  end

  def create?
    user.present?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.user == user
  end

  def collaborator?
    record.search_permissions.exists?(user: user)
  end
end
