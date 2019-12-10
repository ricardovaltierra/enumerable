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
  end

  def my_all
  end

  def my_any
  end

  def my_none
  end

  def my_count
  end

  def my_map
  end

  def my_inject
  end

  def multiply_els
  end

end

arr = [2,1,5,10,400,62]

