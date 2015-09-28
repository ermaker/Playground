module Conway
  class Life
    def initialize(array)
      @array = array
      @boundary = [@array.size, @array.first.size]
    end

    def normalize(*position)
      position.zip(@boundary).map do |p, b|
        if p >= b
          p - b
        else
          p
        end
      end
    end

    def value(*position)
      @array[position[0]][position[1]]
    end

    NEIGHBOURS = [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ]

    def neighbours(*position)
      neighbours_positions = NEIGHBOURS.map do |n|
        normalize(*n.zip(position).map { |n_, p_| n_ + p_ })
      end
      neighbours_positions.map { |n| value(*n) }
    end

    def sum(*position)
      neighbours(*position).reduce(:+)
    end

    DEAD_COND = [3]
    ALIVE_COND = [2, 3]

    def next_value(*position)
      cond =
        case value(*position)
        when 0
          DEAD_COND
        when 1
          ALIVE_COND
        else
          fail
        end
      cond.include?(sum(*position)) ? 1 : 0
    end

    def next_generation
      @array.map.with_index do |line, line_index|
        line.map.with_index do |_cell, cell_index|
          next_value(line_index, cell_index)
        end
      end
    end
  end
end
