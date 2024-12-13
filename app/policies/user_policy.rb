class UserPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index?; user.admin? || user.manager?; end
  def show?; user.admin? || user.manager?; end
  def update?; user.admin? || (user.manager? && !record.admin?); end
  def create?; update?; end
  def new?; update?; end
  def edit?; update?; end
  def destroy?; update?; end
  def block?; update?; end
  def activate?; update?; end
  def search?; index?; end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
