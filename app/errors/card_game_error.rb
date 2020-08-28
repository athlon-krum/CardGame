# frozen_string_literal: true

class CardGameError < StandardError
  def initialize(message)
    @message = message || 'You are not allowed to execute the requested action'
  end

  class NotAuthorized < self
  end
end
