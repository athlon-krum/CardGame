class GamesPolicy < ApplicationPolicy
  def create?
    user.is_admin?
  end
end

class ApplicationPolicy
  def initialize(user, record=nil)
    @user = user
    @record = record
  end

  attr_reader :user, :record
end