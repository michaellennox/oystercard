require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}
  let(:station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) {{entry: entry_station, exit: exit_station, }}

  context '<><><> without working balance <><><>' do
    describe '#balance' do
      it 'should have a balance of 0' do
        expect(card.balance).to eq 0
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
      it 'should create a journey after touch in' do
        card.touch_in(station)
        expect(card.current_journey).not_to be nil
      end

      it 'a penalty charge should be deducted if user touches in without touching out' do
          card.touch_in(station)
          card.touch_in(station)
          expect(card.balance).to eq 84
      end
    end

    describe '#touch_out' do
      it 'penalty charge should be deducted if user touches out without touching in' do
          card.touch_out(station)
          expect(card.balance).to eq 84
      end

      it 'should, on touch out, update the balance deducting the journey fare' do
        card.touch_in(station)
        card.touch_out(station)
        expect(card.balance).to eq Oystercard::MAXIMUM_BALANCE - Oystercard::MINIMUM_FARE
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
      it 'should store the latest journey' do
        card.touch_in(station)
        card.touch_out(exit_station)
        expect(card.journeys).to include ({entry: station, exit: exit_station})
      end
    end
  end
end
