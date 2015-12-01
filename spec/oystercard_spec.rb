require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it 'returns balance as 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds cash to the oystercard' do
      2.times { subject.top_up(10) }
      expect(subject.balance).to eq 20
    end

    it 'has a maximum of 90' do
      subject.top_up(90)
      expect{subject.top_up(1)}.to raise_error "Card at limit"
    end
  end

end
