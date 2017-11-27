defmodule BJ.Game do
   alias Cardshuffle

  def new_game() do
    %BJ.State {
      current_shuffle: Cardshuffle.shuffle_cards()
    }
    |> dealer_one_more(BJ.state.dealer_sideoff)
    |> dealer_one_more(BJ.state.dealer_sideoff)
    |> player_one_more()
    |> player_one_more() 
  end


  def make_move(game = %{ game_state: state }, _option) when state in [:busted, :won, :lost] do
    game
    |> reurn_with_tally()
  end


  #user input h will get another card
  def make_move(game, option = "h") do
    game
    |>player_one_more()
    |> return_with_tally()
  end

  #user input anyother key will stay
  def make_move(game, _option) do
    game
    |>dealer_turn()
  end

  def tally(game) do
    %{
      game_state:             game.game_state,
      player_cards:           game.player_cards,
      player_points:          game.player_points,
      dealercard_sideon:      game.dealercard_sideon
    }  
  end

#######################################################
# helper functio #n
########################################################
  defp dealer_one_more(game, {}) do
    [new_card| _tail] = game.current_shuffle
    %{ game| 
       current_shuffle: current_shuffle - new_card,
       dealer_sideoff: new_card
    } 
  end

  defp dealer_one_more(game, _dealer_sideoff) do
    [new_card| _tail] = game.current_shuffle
    %{ game| current_shuffle: current_shuffle - new_card}
    |> update_dealer_cards(new_card) 
  end
  
  defp update_dealer_cards(game, new_card) do
    Map.put(game, :dealer_sideon, MapSet.put(game.dealer_sideon, new_card))
    new_card_points = getpoints(new_card)
    %{ game | dealer_points: dealer_points + new_card_points }
    |> dealer_checkbust
  end

  
  defp player_one_more(game) do
    [new_card|_tail] = game.current_shuffle
    %{ game | current_shuffle: current_shuffle - new_card }
    |> update_player_cards(new_card)
  end
  
  defp dealer_turn(game) do
    Map.put(game, :dealer_sideon, MapSet.put(game.dealer_sideon, game.dealer_sideoff))
    checkstay(game, game.dealer_points) 
  end

  defp checkstay(game, dealer_points >= 17) do
    compare_results(game)
  end


  defp checkstay(game, _dealer_points) do
    game
    |>dealer_one_more(game.dealer_sideoff)
    if game.game_state = :win do
      game
    else
      checkstay(game,game.dealer_points)
    end
  end


  defp compare_results(game)
    if game.dealer_points >= game.player_points do
      %{ game | game_state: :lost }
    else
      %{ game | game_state: :win }
  end

  defp update_player_cards(game, new_card) do
    Map.put(game, :player_cards, MapSet.put(game.player_cards, new_card))
    new_card_points = getpoints(new_card)
    %{ game | player_points: player_points + new_card_points }
    |> player_checkbust
  end

  defp player_checkbust(game) when game.player_points > 21 do
    %{ game | game_state: :busted }
  end
  defp player_checkbust(game) do
    game
  end

  defp dealer_checkbust(game) when game.dealer_points > 21 do
    %{ game | game_state: :win }
  end
  defp dealer_checkbust(game) do
    game
  end

  defp getpoints({_card_type, :ace}) do
    1
  end

  defp getpoints({_card_type, :two}) do
    2
  end

  defp getpoints({_card_type, :three}) do
    3
  end

  defp getpoints({_card_type, :four}) do
    4
  end

  defp getpoints({_card_type, :five}) do
    5
  end

  defp getpoints({_card_type, :six}) do
    6
  end

  defp getpoints({_card_type, :seven}) do
    7
  end

  defp getpoints({_card_type, :eight}) do
    8
  end

  defp getpoints({_card_type, :nine}) do
    9
  end

  defp getpoints({_card_type, _card_number}) do
    10
  end

  defp return_with_tally(game) do
    { game, tally(game) }
  end

end
