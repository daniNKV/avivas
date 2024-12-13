class ProductPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index?; user.admin? || user.manager? || user.employee?; end
  def show?; index?; end
  def update?; index?; end
  def create?; index?; end
  def new?; index?; end
  def edit?; index?; end
  def destroy?; index?; end
  def update_stock?; index?; end
  def add_images?; index?; end
  def destroy_image?; index?; end
  def publish?; index?; end
  def hide?; index?; end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
