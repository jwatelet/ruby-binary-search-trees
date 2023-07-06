class Node

  include Comparable
  attr_accessor :data, :left, :right

  def initialize(value)
    @data = value
    @left = nil
    @right = nil
  end

  def <=>(other)
    data <=> other.data
  end
end
