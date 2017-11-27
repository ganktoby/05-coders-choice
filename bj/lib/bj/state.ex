defmodule BJ.State do

  defstruct(
    game_state: :playing,
    dealer_sideon: MapSet.new([]),
    dealer_sideoff: {},
    dealer_points: 0,
    player_points: 0,
    player_cards: MapSet.new([]),
    current_shuffle: []
  )
end
