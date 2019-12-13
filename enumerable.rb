# frozen_string_literal: true

module Enumerable
  # EACH
  def my_each
    return to_enum(:enum) unless block_given?

    temp = self
    i = 0
    while i < temp.length
      yield(temp[i])
      i += 1
    end
  end

  # EACH_WITH_INDEX
  def my_each_with_index
    return to_enum(:enum) unless block_given?

    temp = self
    i = 0
    while i < temp.length
      yield(temp[i], i)
      i += 1
    end
  end

  # SELECT
  def my_select
    return to_enum(:enum) unless block_given?

    temp = []
    my_each { |e| temp << e if yield(e) }
    temp
  end

  # ALL?
  def my_all?(pattern = nil)
    flag = true
    if pattern # If a pattern is given
      my_each { |element| !(pattern === element) ? flag = false : flag = true }
    elsif block_given? # If a block is given
      my_each { |element| !yield(element) ? flag = false : true }
    else # If nothing is given
      my_each { |element| !element ? flag = false : true }
    end
    flag
  end

  # ANY?
  def my_any?(pattern = nil)
    flag = false
    if pattern # If a pattern is given
      my_each { |element| pattern === element ? flag = true : false }
    elsif block_given? # If a block is given
      my_each { |element| yield(element) ? flag = true : false }
    else # If nothing is given
      my_each { |element| element ? flag = true : false }
    end
    flag
  end

  # NONE?
  def my_none?(pattern = nil, &block)
    !my_any?(pattern, &block)
  end

  # COUNT
  def my_count(item = nil)
    count = 0
    my_each do |z|
      if block_given?
        count += 1 if yield(z)
      elsif !item.nil?
        count += 1 if item == z
      else
        count = length
      end
    end
    count
  end

  # MAP
  def my_map(&proc)
    temp = []
    my_each do |f|
      if block_given?
        temp << yield(f)
      elsif temp << defined?(proc)
        proc.call(f)
      else
        return to_enum(:enum)
      end
    end
    temp
  end

  # INJECT
  def my_inject(*init)
    result = nil
    arr = dup.to_a
    if block_given?
      result = init[0].nil? ? arr[0] : init[0]
      arr.shift if init[0].nil?
      arr.my_each { |y| result = yield(result, y) }
    elsif !block_given?
      if init[1].nil?
        sym = init[0]
        result = arr[0]
        arr[1..-1].my_each { |i| result = result.send(sym, i) }
      elsif !init[1].nil?
        sym = init[1]
        result = init[0]
        arr.my_each { |h| result = result.send(sym, h) }
      end
    end
    result
  end
end

# MULTIPLY_ELS (inject test)
def multiply_els(array)
  array.my_inject { |res, c| res * c }
end
