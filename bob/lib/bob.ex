defmodule Bob do

  def hey(input) do
    input = String.trim(input)
    cond do
      input == "" -> "Fine. Be that way!"
      input =~ ~r/\?$/ -> resolve_caps(input, "Calm down, I know what I'm doing!", "Sure.")
      true -> resolve_caps(input, "Whoa, chill out!", "Whatever.")
    end
  end

  defp resolve_caps(input, caps, no_caps) do
    clean = String.replace(input, ~r/[[:punct:]]|[[:space:]]|\d/u, "")
    cond do
      clean =~ ~r/^[[:upper:]]+$/u -> caps
      true -> no_caps
    end
  end
end
