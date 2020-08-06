# Enumerable Methods

> Microverse Ruby Project.

<p align="right">
  <br>
  <a href="https://github.com/ricardovaltierra/enumerable">Explore the repo »</a>
  <br>
  <a href="https://github.com/ricardovaltierra/enumerable/issues">Request Feature</a>
</p>

## Table of Contents

* [About the Project](#about-the-project)

* [Built With](#built-with)

* [Code](#code)

* [Getting Started](#getting-started)

* [Contributing](#contributing)

* [Contact](#contact)

* [MIT License](#mit-license)

## About The Project

Own implementation for Ruby's native enumerable module with the following methods:

- each
- each_with_index 
- select
- map
- count
- inject

And boolean returning:

- all?
- none?
- any?

* *Including small `inject` test

The project specifications can be found [here.](https://github.com/TheOdinProject/curriculum/blob/master/ruby_programming/archive/basic_ruby/project_advanced_building_blocks.md)

Feel free to use and recommend it.

## Built With

* [Ruby 2.6.4](https://www.ruby-lang.org/en/news/2019/08/28/ruby-2-6-4-released/)

## Code

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


## Getting Started

To get a local copy up and running follow these simple steps.

Clone or fork the <a href="https://github.com/ricardovaltierra/bootstrap/">repo</a> [git@github.com:ricardovaltierra/bootstrap.git].

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project.

2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).

3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).

4. Push to the Branch (`git push origin feature/AmazingFeature`).

5. Open a Pull Request.

## Contact

Ricardo Valtierra - [@RicardoValtie15](https://twitter.com/RicardoValtie15) - ricardo_valtierra@outlook.com  - [linkedin.com/in/ricardovaltierra/](https://www.linkedin.com/in/ricardovaltierra/)

## MIT License

This project is under the [MIT](LICENSE) license.
