class Card
  include Comparable

  SUITES = %i[spades diamonds hearts clubs]
  RANKS = %w[ace 2 3 4 5 6 7 8 9 10 jack queen king]

  attr_reader :rank_index, :suite_index

  def self.load(rank_index, suite_index)
    Card.new(RANKS[rank_index], SUITES[suite_index])
  end

  def self.dump(card)
    [card.rank_index, card.suite_index]
  end

  def initialize(rank, suite)
    @rank_index = RANKS.index(rank)
    @suite_index = SUITES.index(suite)
  end

  def rank
    RANKS[rank_index]
  end

  def suite
    SUITES[suite_index]
  end

  def to_s
    "#{rank.capitalize} of #{suite.capitalize}"
  end

  def <=>(other)
    [rank_index, suite_index] <=> [other.rank_index, other.suite_index]
  end

  def self.draw_card(game_id)
    card = Card.where(deck_id: Game.find(game_id)).first
    Card.where(deck_id: Game.find(game_id))
      .delete(Card.where(deck_id: Game.find(game_id))[0])
    card
  end
end
