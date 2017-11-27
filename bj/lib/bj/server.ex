defmodule BJ.Server do
  use GenServer
  alias BJ.Game, as: Game



  def init(args \\ []) do
    { :ok,Game.new_game(args) }
  end

  def handle_call({ :new_game }, _from, _state) do
    newgame = Game.new_game()
    { :reply, newgame, newgame}
  end


  def handle_call({ :tally }, _from, state)do
    { :reply, Game.tally(state), state }
  end

  def handle_call({:make_move,option}, _from, _state)do
    {state, tally} = Game.make_move(state, option)
    {:reply, { state,tally },state}
  end


end

