require 'oystercard'

describe Oystercard do
  subject(:oystercard){described_class.new}

  it 'is expected to initialise with balance 0 ' do
    expect(oystercard.balance).to eq 0 
  end

end
