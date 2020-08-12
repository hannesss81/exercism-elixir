defmodule RobotSimulator do
  defstruct direction: :north, position: {0, 0}

  @directions [:north, :east, :south, :west]
  @dir_mappings [north: 0, east: 1, south: 2, west: 3]

  @instructions ["L", "R", "A"]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(), do: %RobotSimulator{}
  def create(direction, _) when direction not in @directions, do: {:error, "invalid direction"}
  def create(direction, {x, y}) when is_integer(x) and is_integer(y), do: %RobotSimulator{direction: direction, position: {x, y}}
  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    do_simulate(robot, String.graphemes(instructions))
  end

  defp do_simulate(robot, []), do: robot
  defp do_simulate(robot, [cmd | tail]) do
    if cmd in @instructions do
      do_simulate(move(robot, cmd), tail)
    else
      {:error, "invalid instruction"}
    end
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
