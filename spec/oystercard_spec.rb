require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE}

  describe '#balance' do
    it 'creates a card with a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'tops up the card by a value and returns the balance' do
      expect { card.top_up(1) }.to change { card.balance }.by 1
    end

    it 'will not allow balance to exceed maximum balance' do
      card.top_up(maximum_balance)
      expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum_balance} exceeded")
    end
  end

  describe '#deduct' do
    it 'will deduct a fare from the balance' do
      card.top_up(10)
      expect{card.deduct(1)}.to change{card.balance}.by(-1)
    end
  end

end
