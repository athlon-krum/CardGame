class ApplicationController < ActionController::Base
  private

  def policy_context
    OpenStruct.new(user: current_user, controller: self)
  end
end
