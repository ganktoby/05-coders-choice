defmodule HumanPlayer do

  defdelegate play(), to HumanPlayer.Impl

end
