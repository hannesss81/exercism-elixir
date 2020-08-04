defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.scan(~r/[[:alnum:]-]+/iu, String.downcase(sentence))
    |> List.flatten()
    |> Enum.reduce(
         Map.new(),
         fn x, acc ->
           Map.update(acc, x, 1, fn i -> i + 1 end)
         end
       )
  end
end
