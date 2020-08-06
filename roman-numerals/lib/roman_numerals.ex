defmodule RomanNumerals do

  @dec_to_rom [
    {1, "I"},
    {4, "IV"},
    {5, "V"},
    {9, "IX"},
    {10, "X"},
    {40, "XL"},
    {50, "L"},
    {90, "XC"},
    {100, "C"},
    {400, "CD"},
    {500, "D"},
    {900, "CM"},
    {1000, "M"},
    {9999, ""}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    case number do
      0 -> ""
      _ ->
        {highest, roman} = convert_highest(number, @dec_to_rom)
        roman <> numeral(number - highest)

    end
  end

  defp convert_highest(number, remaining) do
    [{prev, prev_r}, {cur, cur_r} | _] = remaining
    cond do
      number > cur -> convert_highest(number, tl(remaining))
      number < cur -> {prev, prev_r}
      number == cur -> {cur, cur_r}
    end
  end

end
