require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) {double(:station)}

  context 'card has a working balance' do

    before(:example) { oystercard.top_up 10 }

    describe '#top_up' do
      it 'adds cash to the oystercard' do
        expect{ oystercard.top_up 10 }.to change{ oystercard.balance }.by 10
      end
    end

    describe '#touch_out' do
      context 'while in_journey' do
        before(:example) {oystercard.touch_in(station)}

        it 'changes the current status of in_journey? to false' do
          expect{oystercard.touch_out(station)}.to change{oystercard.in_journey?}.to false
        end

        it "reduces the balance by £#{Oystercard::MINIMUM_CHARGE}" do
          expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-Oystercard::MINIMUM_CHARGE)
        end

        it "forgets entry station" do
          oystercard.touch_out(station)
          expect(oystercard.journey.entry_station).to be nil
        end

        it 'will store all previous trips in the journey_list variable' do
          moorgate, liverpoolst, kingsx = double(:station), double(:station), double(:station)
          oystercard.touch_out(moorgate)
          oystercard.touch_in(liverpoolst)
          oystercard.touch_out(kingsx)
          expect(oystercard.journey.journey_list).to eq({ station => moorgate, liverpoolst => kingsx })
        end

      end
    end

    describe '#touch_in' do
      it 'changes the current status of in_journey? to true' do
        expect{ oystercard.touch_in(station) }.to change{ oystercard.in_journey? }.to true
      end

      it 'changes the value of entry_station to whatever is passed' do
        expect{ oystercard.touch_in station }.to change{ oystercard.journey.entry_station }.to station
      end
    end


  end

  describe '#balance' do
    it 'returns balance as 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it "does not top up over capacity of £#{Oystercard::MAXIMUM_CAPACITY}" do
      oystercard.top_up(Oystercard::MAXIMUM_CAPACITY)
      over_limit = "Card at limit £#{Oystercard::MAXIMUM_CAPACITY}"
      expect{ oystercard.top_up(1) }.to raise_error over_limit
    end
  end

  describe '#in_journey?' do
    it 'by default card is not in journey' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it "will not let you through, if balance below £#{Oystercard::MINIMUM_BALANCE}"  do
      expect{oystercard.touch_in(station)}.to raise_error "Must top up oystercard"
    end
  end

end
