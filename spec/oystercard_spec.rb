require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it 'returns balance as 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe 'top_up' do
    it 'adds cash to the oystercard' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
  end

end
