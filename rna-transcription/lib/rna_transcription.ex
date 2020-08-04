defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  #  @spec to_rna([char]) :: [char]
  #  def to_rna(?G), do: ?C
  #  def to_rna(?C), do: ?G
  #  def to_rna(?T), do: ?A
  #  def to_rna(?A), do: ?U
  #  def to_rna(dna) do
  #    Enum.reduce(dna, [], fn (x, acc) -> acc ++ [to_rna(x)] end)
  #  end

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(
      dna,
      fn x -> case x do
                ?G -> ?C
                ?C -> ?G
                ?T -> ?A
                ?A -> ?U
              end
      end
    )
  end
end
