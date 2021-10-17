# Holds a grid position
class Position
  attr_reader :row, :col

  def initialize(row, col)
    raise ArgumentError, 'Position values must be integers' unless row.is_a?(Integer) && col.is_a?(Integer)

    @row = row
    @col = col
  end

  # Has the position's row & col values been properly initialized?
  # (optional) Are the values in range, meaning between zero and max specified
  # in the parameters? If no maximum is specified, all integer values are
  # concidered valid.
  # @param max_row [Integer] (optional) The maximum value @row can take
  # @param max_col [Integer] (optional) The maximum value @col can take
  # @return [true, false]
  def valid?(max_row = nil, max_col = nil)
    # Have both row and col been initialized?
    return false if @row.nil? || @col.nil?

    # Is the row in range?
    return false unless max_row.nil? || (0..max_row).cover?(@row)
    # Is the col in range?
    return false unless max_col.nil? || (0..max_col).cover?(@col)

    true
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
    "#<Position: @row=#{@row}, @col=#{@col}>"
  end
end
