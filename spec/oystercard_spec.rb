require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  context '#balance' do
    it 'creates a card with a balance' do
      expect(card.balance).to eq 0
    end
  end
  context '#top_up' do
    it 'tops up the card by a value and returns the balance' do
      expect { card.top_up(1) }.to change { card.balance }.by 1
    end

    it 'will not allow balance to exceed 90' do
      card.top_up(90)
      expect{card.top_up(1)}.to raise_error("Maximum balance of £#{Oystercard::MAXIMUM_BALANCE} exceeded")
    end
  end
end
