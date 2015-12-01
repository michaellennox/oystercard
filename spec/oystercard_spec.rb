require 'oystercard'
describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe '#balance' do
    it 'returns balance as 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds cash to the oystercard' do
      2.times { oystercard.top_up(10) }
      expect(oystercard.balance).to eq 20
    end

    it "has a maximum of #{Oystercard::MAXIMUM_CAPACITY}" do
      oystercard.top_up(Oystercard::MAXIMUM_CAPACITY)
      over_limit = "Card at limit £#{Oystercard::MAXIMUM_CAPACITY}"
      expect{ oystercard.top_up(1) }.to raise_error over_limit
    end
  end

  describe '#deduct' do
    it 'deducts cash from the oystercard' do
      oystercard.top_up(10)
      expect{ oystercard.deduct(5) }.to change{ oystercard.balance }.by (-5)
    end
  end

end
