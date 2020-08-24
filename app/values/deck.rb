class Deck
  def self.load(value)
    Deck.new(value.map { |(rank_index, suite_index)| Card.load(rank_index, suite_index) })
  end

  def self.dump(deck)
    deck.to_a.map { |card| Card.dump(card) }
  end

  def self.default_deck
    Card::RANKS.product(Card::SUITES).map do |(rank, suite)|
      Card.new(rank, suite)
    end
  end

  def initialize(deck=Deck.default_deck)
    @deck = deck
  end

  def to_a
    deck
  end

  def shuffle!
    deck.shuffle!
    self
  end

  private

  attr_reader :deck
end
