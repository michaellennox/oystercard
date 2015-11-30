require 'oystercard'

describe Oystercard do
  subject(:oystercard){described_class.new}

  it 'is expected to initialise with balance 0 ' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do

    it 'is expected to return the argument passed plus current balance' do
      expect(oystercard.top_up(5)).to eq 5
    end

    it 'is expected to add the argument passed to the balance variable' do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq 5
    end
    
  end

end
