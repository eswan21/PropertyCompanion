class SearchPermissionPolicy < ApplicationPolicy
  def create?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.search.user == user
  end
end
