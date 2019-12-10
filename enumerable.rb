# frozen_string_literal: true

module Enumerable

  # my 'each' version
  def my_each
    temp = self
    i = 0
    while i < temp.length do 
      yield(temp[i])
      i += 1
    end
  end

  def my_each_with_index
    temp = self
    i = 0
    while i < temp.length do 
      yield(temp[i], i)
      i += 1
    end
  end

  def my_select
    temp = []
    my_each { |e| temp << e if yield(e) }
    temp
  end

  def my_all?
    test = true
    my_each { |d| break unless test = yield(d) }
    test
  end

  def my_any?
    test = false
    my_each { |u| break if test = yield(u) }
    test
  end

  def my_none?
    test = true
    my_each { |t| break unless test = !yield(t) }
    test
  end

  def my_count
    total = 0
    my_each { |z| block_given? ? (total += 1 if yield(z)) : (total += 1) }
    total
  end

  def my_map
  end

  def my_inject
  end

  def multiply_els
  end

end