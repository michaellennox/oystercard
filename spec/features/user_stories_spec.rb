describe 'User Stories' do

  let(:oystercard) { Oystercard.new }

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'fare is deducted from the card' do
    oystercard.top_up(50)
    expect{ oystercard.deduct(5) }.to change{ oystercard.balance }.by (-5)
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.

  context 'card has a working balance' do

    before(:example) { oystercard.top_up 10 }

    it 'by default customer not in journey' do
      expect(oystercard).not_to be_in_journey
    end

    it 'customer is in journey after touching in' do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it 'customer is not in journey after touching out' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.

  it 'will not let you through, if you have not got a working balance' do
    expect{oystercard.touch_in}.to raise_error "Must top up oystercard"
  end

end
