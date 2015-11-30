require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'is expected to initialise with balance 0 ' do
    expect(oystercard.balance).to eq 0
  end

  context 'while card has a working balance' do

    before { oystercard.top_up(10) }

    describe '#top_up' do

      it 'is expected to add the argument passed to the balance variable' do
        expect(oystercard.balance).to eq 10
      end

    end

    describe '#deduct' do

      it 'is expected to return the current balance minus argument passed' do
        expect(oystercard.deduct(5)).to eq 5
      end

      it 'is expected to reduce current balance by argument passed' do
        expect{ oystercard.deduct(8) }.to change{ subject.balance }.by (-8)
      end

    end

    describe '#touch_in' do

      it 'is expected to change in_journey? to true' do
        oystercard.touch_in
        expect(oystercard).to be_in_journey
      end

    end

    describe '#touch_out' do
      it 'is expected to change in_journey? to false' do
        oystercard.touch_in
        oystercard.touch_out
        expect(oystercard).not_to be_in_journey
      end
    end

  end

  context 'while card does not have a working balance' do
    describe '#top_up' do

      it 'is expected to return the argument passed plus current balance' do
        expect(oystercard.top_up(5)).to eq 5
      end

      it 'is expected to raise error if topup will raise balance over cap' do
        oystercard.top_up(Oystercard::CARD_CAP)
        cap_exceeded = "Cap exceeded £#{Oystercard::CARD_CAP}"
        expect { oystercard.top_up(1) }.to raise_error cap_exceeded
      end

    end

    describe '#in_journey?' do

      it 'is in_journey? false on initialisation' do
        expect(oystercard.in_journey?).to be false
      end

    end

    describe '#touch_in' do

      it 'is expected to raise an error if balance is below £1 at time of touch in' do
        expect{ oystercard.touch_in }.to raise_error "Balance too low, please top up"
      end

    end
  end

end
