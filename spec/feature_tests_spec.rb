describe "Feature Tests" do
  let(:card) {Oystercard.new}
  let(:maximum) {Oystercard::MAXIMUM_BALANCE}

  it 'creates a card with a balance' do
    expect(card.balance).to eq 0
  end

  it 'tops up the card by a value and returns the balance' do
    expect{card.top_up(1)}.to change{card.balance}.by(1)
  end

  it 'will not allow balance to exceed 90' do
    card.top_up(90)
    expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum} exceeded")
  end

end
