# frozen_string_literal: true

class ApplicationPolicy
  def initialize(context, record=nil)
    @context = context
    @record = record
  end

  attr_reader :user, :record

  class Scope
    def initialize(context, scope)
      @context = context
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
