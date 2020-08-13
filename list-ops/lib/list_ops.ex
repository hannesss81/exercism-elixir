defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([_ | t]), do: count(t) + 1
  def count([]), do: 0

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])
  defp do_reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, [])
  end

  defp do_map([h | t], f, acc), do: [f.(h) | do_map(t, f, acc)]
  defp do_map([], _f, acc), do: acc

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, [])
  end

  defp do_filter([h | t], f, acc) do
    case f.(h) do
      true -> [h | do_filter(t, f, acc)]
      false -> do_filter(t, f, acc)
    end
  end

  defp do_filter([], _f, acc), do: acc

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)
  def reduce([], acc, _f), do: acc

  @spec append(list, list) :: list
  def append([h | t], b), do: [h | append(t, b)]
  def append([], b), do: b

  @spec concat([[any]]) :: [any]
  def concat([h | t]), do: append(h, concat(t))
  def concat([]), do: []
end
