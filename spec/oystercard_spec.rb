require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}
  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) {{entry: entry_station, exit: exit_station, }}

  context '<><><> without working balance <><><>' do
    describe '#balance' do
      it 'should have a balance of 0' do
        expect(card.balance).to eq 0
      end
    end

    describe '#in_journey?' do
      it 'should return false when not being used in a journey' do
        expect(card).not_to be_in_journey
      end
    end

    describe '#top_up' do
      it 'should increase the existing balance by an amount' do
          expect{ card.top_up(1) }.to change {card.balance}.by 1
      end
    end

    describe '#touch_in' do
      it 'should raise an error when user tries to touch in if balance is lower than 1' do
        expect {card.touch_in(station)}.to raise_error "Your balance is too low. Please top up!"
      end
    end
  end

  context '<><><> with working balance <><><>' do

    before do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
    end

    describe '#touch_in' do
      it 'should return in journey true after touch in is called' do
        card.touch_in(station)
        expect(card).to be_in_journey
      end

      it 'should, on touch in, record the entry station' do
        card.touch_in(station)
        expect(card.journey[:entry]).to eq station
      end
    end

    describe '#touch_out' do
      it 'should return in journey false after touch out is called' do
        card.touch_in(station)
        card.touch_out(station)
        expect(card).not_to be_in_journey
      end

      it 'should, on touch out, update the balance deducting the journey fare' do
        card.touch_in(station)
        card.touch_out(station)
        expect(card.balance).to eq Oystercard::MAXIMUM_BALANCE - Oystercard::MINIMUM_FARE
      end

      it 'should, on touch out, reset the entry station to nil' do
        card.touch_in(station)
        card.touch_out(station)
        expect(card.journey[:entry]).to eq nil
      end
    end

    describe '#top_up' do
      it 'should raise an error if the amount exceeds the limit' do
        amount = 5
        expect{ card.top_up(amount)}.to raise_error("card limit of #{Oystercard::MAXIMUM_BALANCE} exceeded")
      end
    end

    describe '#deduct' do
      it 'should return the updated balance when money is deducted' do
        amount = 5
        expect(card.deduct(amount)).to eq Oystercard::MAXIMUM_BALANCE - amount
      end
    end

    describe '#journeys' do
      it 'should be empty by deafault' do
        expect(card.journeys).to be_empty
      end
    end

    describe '#journey' do
      it 'stores a journey' do
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journeys).to include journey
      end
    end
  end
end
