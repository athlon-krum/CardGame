class ApplicationController < ActionController::Base
  private

  def current_user
    nil
  end

  def policy_context
    OpenStruct.new(user: current_user, controller: self)
  end
end
