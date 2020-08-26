module Games
  class DrawCard
    include UseCase

    attr_reader :card

    def initialize(game)
      super
      @game = game
    end

    def perform
      ActiveRecord::Base.transaction do
        draw_card
        save_game if success?

        raise ActiveRecord::Rollback if failure?
      end
    end

    private

    attr_reader :game

    def draw_card
      @card = game.draw_card

      errors.add(:base, 'No cards left in the deck!') unless card
    end

    def save_game
      game.save

      errors.copy!(game.errors)
    end
  end
end
