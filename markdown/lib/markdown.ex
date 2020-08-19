defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> patch_list()
  end

  defp process(row = "#" <> _), do: enclose_with_header_tag(parse_header_md_level(row))
  defp process(row = "*" <> _), do: parse_list_md_level(row)
  defp process(row), do: enclose_with_paragraph_tag(String.split(row))

  defp parse_header_md_level(row) do
    [header | content] = String.split(row)
    {String.length(header), Enum.join(content, " ")}
  end

  defp parse_list_md_level(row) do
    content = String.split(String.trim_leading(row, "* "))
    "<li>" <> join_words_with_tags(content) <> "</li>"
  end

  defp enclose_with_header_tag({l, content}) do
    "<h#{l}>#{content}</h#{l}>"
  end

  defp enclose_with_paragraph_tag(content) do
    "<p>#{join_words_with_tags(content)}</p>"
  end

  defp join_words_with_tags(words_md) do
    words_md
    |> Enum.map_join(" ", &replace_md_with_tag/1)
  end

  defp replace_md_with_tag(word_md) do
    word_md
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(word_md) do
    cond do
      String.starts_with?(word_md, "__") -> String.replace_prefix(word_md, "__", "<strong>")
      String.starts_with?(word_md, "_") -> String.replace_prefix(word_md, "_", "<em>")
      true -> word_md
    end
  end

  defp replace_suffix_md(word_md) do
    cond do
      String.ends_with?(word_md, "__") -> String.replace_suffix(word_md, "__", "</strong>")
      String.ends_with?(word_md, "_") -> String.replace_suffix(word_md, "_", "</em>")
      true -> word_md
    end
  end

  defp patch_list(row) do
    row
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
