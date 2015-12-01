require 'oystercard'
describe Oystercard do

  subject(:oystercard) { described_class.new }

  context 'card has a working balance' do

    before(:example) { oystercard.top_up 10 }

    describe '#top_up' do
      it 'adds cash to the oystercard' do
        expect{ oystercard.top_up 10 }.to change{ oystercard.balance }.by 10
      end
    end

    describe '#touch_out' do
      it 'changes the current status of in_journey? to false' do
        oystercard.touch_in
        expect{oystercard.touch_out}.to change{oystercard.in_journey?}.to false
      end
    end

    describe '#touch_in' do
      it 'changes the current status of in_journey? to true' do
        expect{ oystercard.touch_in }.to change{ oystercard.in_journey? }.to true
      end
    end

    describe '#deduct' do
      it 'deducts cash from the oystercard' do
        expect{ oystercard.deduct(5) }.to change{ oystercard.balance }.by (-5)
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
      expect{oystercard.touch_in}.to raise_error "Must top up oystercard"
    end
  end

end
