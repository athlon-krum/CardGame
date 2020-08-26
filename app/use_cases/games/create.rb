# frozen_string_literal: true

module Games
  class Create
    include UseCase

    def initialize(params)
      @params = params
    end

    def perform
      ActiveRecord::Base.transaction do
        create_game

        raise ActiveRecord::Rollback if failure?
      end
    end

    attr_reader :game

    private

    attr_reader :params

    def create_game
      @game = Game.create(params)

      errors.copy!(game.errors)
    end
  end
end
