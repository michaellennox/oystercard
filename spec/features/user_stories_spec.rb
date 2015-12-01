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
