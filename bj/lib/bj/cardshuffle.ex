defmodule BJ.Cardshuffle do

  def cards() do
    for card_type   <- [:spades, :hards, :clubs, :diamonds],
        card_number <- [:ace, :two, :three, :four, :five, 
                 :six, :seven, :eight, :nine, :ten, 
                 :jack, :queen, :king], do: {card_type, card_number}
  end


  def shuffle_cards(cards) do
    Enum.shuffle(cards)
  end 

end
