describe "Feature Tests" do
  let(:card) {Oystercard.new}

  it 'creates a card with a balance' do
    expect(card.balance).to eq 0
  end

  it 'tops up the card by a value and returns the balance' do
    expect{card.top_up(1)}.to change{card.balance}.by(1)
  end

end
