require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE}
  let(:minimum_fare) {Oystercard::MINIMUM_BALANCE}
  let(:station) {double :station}
  let(:station2) {double :station}

  describe '#initialize' do
    it 'has an empty journey list' do
      expect(card.journey_history).to eq []
    end

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

  describe '#touch_in' do
    it 'raises error if insufficent funds' do
      expect{ card.touch_in(station) }.to raise_error "Insufficent funds: top up"
    end
    it 'charges a penalty fare if journey was not completed before touching in' do
      card.top_up(20)
      card.touch_in(station)
      expect{ card.touch_in(station) }.to change{ card.balance }.by (-6)
    end
  end

  describe '#touch_out' do
    it 'charges customer when they tap out' do
      card.top_up(minimum_fare)
      card.touch_in(station)
      expect{card.touch_out((station))}.to change{card.balance}.by(-minimum_fare)
    end
  end

  xdescribe 'completed journeys' do
    it 'can recall previous journeys' do
      card.top_up(5)
      card.touch_in(station)
      card.touch_out(station2)
      expect(card.journey_history).to eq [{entry_station: station, exit_station: station2}]
    end
  end

  context 'the customer has not touched in' do
    describe '#touch_out' do
      it 'deducts a penalty charge' do
        card.top_up(20)
        expect { card.touch_out(station) }.to change{ card.balance }.by -6
      end
    end
  end
end
