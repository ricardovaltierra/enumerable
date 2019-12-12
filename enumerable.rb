# frozen_string_literal: true

module Enumerable
  #EACH
  def my_each
    temp = self
    i = 0
    return temp unless block_given?
    
    while i < temp.length
      yield(temp[i])
      i += 1
    end
  end
  
  #EACH_WITH_INDEX
  def my_each_with_index
    temp = self
    i = 0
    return temp unless block_given?

    while i < temp.length
      yield(temp[i], i)
      i += 1
    end    
  end

  #SELECT
  def my_select
    return self unless block_given?

    temp = []
    my_each { |e| temp << e if yield(e) }
    temp    
  end

  #ALL?
  def my_all?(pattern = nil)
    if pattern #If a pattern is given
      my_each { |element| 
        unless pattern === element 
           return false
           break
        end
      }
    elsif block_given? #If a block is given
      my_each { |element| 
        unless yield(element)
          return false
          break
        end
      }
    else #If nothing is given
      my_each { |element| 
        unless element 
          return false
          break
        end
      }
    end
    true
  end

  #ANY?
  def my_any?(pattern = nil)
    if pattern #If a pattern is given
      my_each { |element| 
        if pattern === element 
           return true
           break
        end
      }
    elsif block_given? #If a block is given
      my_each { |element| 
        if yield(element)
          return true
          break
        end
      }
    else #If nothing is given
      my_each { |element| 
        if element 
          return true
          break
        end
      }
    end
    false
  end

  #NONE?
  def my_none?(pattern = nil, &block)
    !my_any?(pattern, &block)
  end

  #COUNT
  def my_count(item = nil)
    count = 0
    my_each { |z| block_given? ? (count += 1 if yield(z)) : !item.nil? ? (count += 1 if item == z) : count = length }
    count
  end

  #MAP
  def my_map(&proc)
    temp = []
    my_each { |f| 
      if block_given? 
        temp << yield(f)
      elsif defined?(proc)
       temp << proc.call(f)
      else
        temp << f
      end
    }
    temp
  end

  #INJECT
  def my_inject(init = nil)
    if !init.nil?
      memo = init
      my_each_with_index { |v| memo = yield(memo, v) }
    else
      memo = self[0]
      my_each_with_index { |v, i| memo = yield(memo, v) if i.positive? }
    end
    memo
  end
end

#MULTIPLY_ELS (inject test)
def multiply_els(array)
  array.my_inject(2) { |res, c| res * c }
end

