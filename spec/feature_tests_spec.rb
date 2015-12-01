describe "Feature Tests" do
  let(:card) {Oystercard.new}
  let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
  let(:minimum_fare) {Oystercard::MINIMUM_FARE}

  describe 'behaviour of balance on the card' do
    it 'creates a card with a balance' do
      expect(card.balance).to eq 0
    end

    it 'tops up the card by a value and returns the balance' do
      expect{card.top_up(1)}.to change{card.balance}.by(1)
    end

    it 'will not allow balance to exceed maximum balance' do
      card.top_up(maximum_balance)
      expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum_balance} exceeded")
    end
  end
  describe '#touch_in' do
    it 'allows a card to touch in and begin journey if balance greater than minimum fare' do
      card.top_up(minimum_fare)
      card.touch_in
      expect(card.in_journey?).to eq(true)
    end

    it 'raise error if card balance is zero' do
      expect{card.touch_in}.to raise_error "Insufficent funds: top up"
    end
  end

  describe '#touch_out' do
    it 'allows a card to touch out and end a journey' do
        card.touch_out
        expect(card.in_journey?).to eq(false)
    end

    it 'charges customer when they tap out' do
      expect{card.touch_out}.to change{card.balance}.by(-minimum_fare)
    end
  end

describe '#initialize' do
  it 'is initially not in a journey' do
    expect(card.in_journey?).to eq(false)
  end
end



end
