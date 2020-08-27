# frozen_string_literal: true

module Cards
  class Compare
    include UseCase

    attr_reader :highest

    def initialize(params)
      super
      @params = params[0..1]
    end

    def perform
      build_cards
      check_requirements if success?
      compare_cards if success?
    end

    private

    attr_reader :cards, :params

    def build_cards
      @cards = params.map { |param| Card.build!(param) }
    rescue Card::InvalidParam => e
      errors.add(:base, e.message)
    end

    def check_requirements
      errors.add(:base, 'Both cards should not be equal! Someone is cheating') if cards.first == cards.second
    end

    def compare_cards
      @highest = cards.max
    end
  end
end
