defmodule BJ do
  @me Blackjeck_Server

  def start_link(default \\ []) do
    GenServer.start_link(BJ.Server, default, name: @me)
  end



  def make_move(_game, option) do
    GenServer.call(@me, { :make_move, option })
  end

  def new_game() do
    GenServer.call({@me, { :new_game }})
  end

  def tally(_game) do
    GenServer.call(@me, { :tally})
  end

end

#  defdelegate make_move(game, option), to: Server
#  defdelegate new_game(),              to: Supervisor
#  defdelegate tally(game),             to: Server
#  def start(_type,_args) do
#    import Supervisor.Spec, warn:false
#    children = [
#      worker(BJ.Stash,[]),
#      supervisor(BJ.Supervisor,[])
#    ]
#    opts =[strategy: :one_for_one]
#    pid = spwan(__MODULE__,:listener,[])
#    :global.register_name(@global_name,pid)
#    Supervisor.start_link(children, opts)
#  end  

