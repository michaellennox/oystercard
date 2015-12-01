require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  context '#balance' do
    it 'creates a card with a balance' do
      expect(oystercard.balance).to eq 0
    end
  end
  context '#top_up' do
    it 'tops up the card by a value and returns the balance' do
      expect { oystercard.top_up(1) }.to change { oystercard.balance }.by 1
    end
  end
end
