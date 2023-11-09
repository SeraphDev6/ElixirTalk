defmodule PokerHand do
  @result %{win: 1, loss: 2, tie: 3}
  @rank %{"2" => 1, "3" => 2, "4" => 3, "5" => 4, "6" => 5, "7" => 6, "8" => 7, "9" => 8,
  "T" => 9, "Q" => 10, "K" => 11, "A" => 12}
  def compare(player, opponent) do

    get_rank(player)
  end

  def get_rank(hand) do
    case is_flush?(hand) do
      true -> case is_straight?(hand) do
                true -> 8 # straight flush
                false -> 5 # just a flush
              end
      false -> 0
    end
  end

  def is_straight?(hand) do
    String.split(hand)
    |> Enum.map(fn x -> @rank |> Map.fetch(String.at(x,0)) end)
    |> Enum.sort()
    |> Enum.reduce({true, nil}, fn {:ok, x}, acc ->
      case acc do
        {false, _} -> {false, nil}
        {true, nil} -> {true, x}
        {true, p} -> {(p + 1 == x), x}
      end
    end)
    |> elem(0)
  end

  def is_flush?(hand) do
    suit = String.at(hand,1)
    String.split(hand)
    |> Enum.all?(fn x -> String.at(x,1) == suit end)
  end

end
