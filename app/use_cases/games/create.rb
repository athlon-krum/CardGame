# frozen_string_literal: true

module Games
  class Create
    include UseCase

    def initialize(contract, params)
      @contract = contract
      @params = params
      @game = contract.model
    end

    def perform
      ActiveRecord::Base.transaction do
        validate_contract
        save_record if success?

        raise ActiveRecord::Rollback if failure?
      end
    end

    attr_reader :game

    private

    attr_reader :params, :contract

    def validate_contract
      errors.copy!(contract.errors) unless contract.validate(params)
    end

    def save_record
      contract.save

      errors.copy!(contract.model.errors)
    end
  end
end
