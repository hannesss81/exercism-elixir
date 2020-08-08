defmodule Bob do

  import String

  def hey(input) do
    input = trim(input)
    cond do
      input == "" -> "Fine. Be that way!"
      ends_with?(input, "?") -> resolve_caps(input, "Calm down, I know what I'm doing!", "Sure.")
      true -> resolve_caps(input, "Whoa, chill out!", "Whatever.")
    end
  end

  defp resolve_caps(input, caps, no_caps) do
    cond do
      # Only symbols
      upcase(input) == downcase(input) -> no_caps
      # All caps
      upcase(input) == input -> caps
      # Everything else (mixed) caps
      true -> no_caps
    end
  end
end
