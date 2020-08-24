# frozen_string_literal: true

module UseCase
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  attr_reader :notes, :warnings

  module ClassMethods
    # The perform method of a UseCase should always return itself
    def call(*args)
      build!(*args).new(*args).tap(&:perform)
    end

    # This class method should return class constant which extends UseCase
    def build(*_args)
      self
    end

    def build!(*args)
      builder = callee = self

      loop do
        callee = builder.build(*args)

        break UseCase::NilUseCase unless callee
        break callee if builder == callee

        builder = callee
      end
    end

    def call!(*args)
      call(*args).tap do |result|
        raise result.errors.full_messages.to_sentence if result.failure?
      end
    end
  end

  def initialize(*___)
    @notes = Notes.new(self)
    @warnings = Warnings.new(self)
    @callbacks = []
  end

  # implement all the steps required to complete this use case
  def perform
    ActiveRecord::Base.transaction do
      yield
      notes.add(:base, t('.success')) if success?

      success? or raise ActiveRecord::Rollback
    end
  end

  # inside of perform, add errors if the use case did not succeed
  def success?
    errors.none?
  end

  def failure?
    !success?
  end

  class Notes < ActiveModel::Errors
  end

  class Warnings < ActiveModel::Errors
  end

  private

  attr_reader :callbacks

  def t(key, options={})
    constants = self.class.name.split('::').map(&:underscore)

    scope = "use_cases.#{constants.join('.')}"

    I18n.t(key, { scope: scope }.merge(options))
  end

  def execute_callbacks
    callbacks.each do |callback|
      if callback.respond_to?(:call)
        callback.call
      else
        self.send(callback)
      end
    end
  end

  class NilUseCase
    include UseCase

    def initialize(*args); end

    def perform; end
  end
end
