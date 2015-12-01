describe 'User Stories' do

  let(:oystercard) { Oystercard.new }

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'fare is deducted from the card' do
    oystercard.top_up(50)
    expect{ oystercard.deduct(5) }.to change{ oystercard.balance }.by (-5)
  end

end
