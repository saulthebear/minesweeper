# Holds a grid position
class Position
  attr_reader :row, :col

  def initialize(row, col)
    raise ArgumentError, 'Position values must be integers' unless row.is_a?(Integer) && col.is_a?(Integer)

    @row = row
    @col = col
  end

  def to_s
    "[#{@row},#{@col}]"
  end

  def hash
    [@row, @col].hash
  end

  def eql?(other)
    @row == other.row && @col == other.col
  end

  def ==(other)
    @row == other.row && @col == other.col
  end

  # Ensure row is printed first
  def inspect
    "#<Position: #{object_id} @row=#{@row}, @col=#{@col}>"
  end
end
