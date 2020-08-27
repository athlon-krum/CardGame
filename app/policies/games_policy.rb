# frozen_string_literal: true

class GamesPolicy < ApplicationPolicy
  def create?
    # context.user.is_admin?
    true
  end

  def draw_card?
    true
  end

  class Scope < ApplicationPolicy::Scope
    #def resolve
    #  if context.user.nil? # anonymous
    #    scope.none
    #  elsif context.user.is_admin?
    #    scope.all
    #  else
    #    scope.where(user: context.user)
    #  end
    #end
  end
end
