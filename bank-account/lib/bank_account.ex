defmodule BankAccount do
  use Agent
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  defstruct [balance: 0]

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {_, pid} = Agent.start_link fn -> %BankAccount{} end
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(pid) do
    Agent.stop(pid)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(pid) do
    if (Process.alive?(pid)) do
      Agent.get(pid, fn ac -> ac.balance end)
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(pid, amount) do
    if (Process.alive?(pid)) do
      Agent.update(pid, fn ac -> %BankAccount{ac | balance: (ac.balance + amount)} end)
    else
      {:error, :account_closed}
    end
  end
end
