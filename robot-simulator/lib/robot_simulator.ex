defmodule RobotSimulator do
  defstruct direction: nil, position: nil

  @directions [:north, :east, :south, :west]
  @dir_mappings [north: 0, east: 1, south: 2, west: 3]

  @instructions ["L", "R", "A"]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    with {:ok, _} <- validate_direction(direction),
         {:ok, _} <- validate_position(position) do
      %RobotSimulator{direction: direction, position: position}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp validate_direction(direction) when direction not in @directions, do: {:error, "invalid direction"}
  defp validate_direction(_), do: {:ok, nil}

  defp validate_position({x, y}) when is_integer(x) and is_integer(y), do: {:ok, nil}
  defp validate_position(_), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.graphemes(instructions)
    |> Enum.reduce_while(
         robot,
         fn cmd, acc ->
           if cmd in @instructions do
             {:cont, move(acc, cmd)}
           else
             {:halt, {:error, "invalid instruction"}}
           end
         end
       )
  end

  defp move(robot, "L") do
    next_direction = Enum.at(@directions, Integer.mod(@dir_mappings[robot.direction] - 1, 4))
    %RobotSimulator{robot | direction: next_direction}
  end

  defp move(robot, "R") do
    next_direction = Enum.at(@directions, Integer.mod(@dir_mappings[robot.direction] + 1, 4))
    %RobotSimulator{robot | direction: next_direction}
  end

  defp move(robot, "A") do
    {x, y} = robot.position
    case robot.direction do
      :north -> %RobotSimulator{robot | position: {x, y + 1}}
      :east -> %RobotSimulator{robot | position: {x + 1, y}}
      :south -> %RobotSimulator{robot | position: {x, y - 1}}
      :west -> %RobotSimulator{robot | position: {x - 1, y}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
