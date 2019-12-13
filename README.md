# enumerable-methods

This project is part of a series of projects to be completed by students of [Microverse](https://www.microverse.org/ 'The Global School for Remote Software Developers!').

The project consist on the implementation of my particular version of Ruby’s enumerable methods.



## 🔗 link to assignment

The full assignment can be found in the Odin Project's HTML and CSS course that can be found [here](https://www.theodinproject.com/courses/ruby-programming/lessons/advanced-building-blocks).



## 📡 technologies used

- Ruby
- Github

Basic ruby and github was used on this project.

## 🚀 the project

This project can be found in https://github.com/ricardovaltierra/enumerable-methods

### ✨ [code picture]

```ruby
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
    return to_enum(:enum) unless block_given?

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
```



## 🤝 contributing

Contributions, issues and feature requests are welcome!<br/>Feel free to check [issues page](https://github.com/ricardovaltierra/enumerable-methods/issues).

1. Fork it (https://github.com/ricardovaltierra/enumerable-methods/development/fork)
2. Create your working branch (git checkout -b [choose-a-name])
3. Commit your changes (git commit -am 'what this commit will fix/add/improve')
4. Push to the branch (git push origin [chosen-name])
5. Create a new pull request



## 🤖 contributor

Ricardo Valtierra - [GitHub](https://github.com/ricardovaltierra)



## 🙋‍♂ show your support

Give a ⭐️ if you like this project!

## 📝 license

This project is [MIT](https://github.com/ricardovaltierra/enumerable-methods/blob/development/LICENSE) licensed.
