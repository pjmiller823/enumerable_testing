require 'irb'

class ReimplementEnumerable
  def initialize(collection)
    @collection = collection
  end

  def select
    result = []

    @collection.each do |element|
      should_select = yield(element)
      if should_select
        result << element
      end
    end

    return result
  end

  def all?
    new_all = []

    @collection.each do |element|
      if yield(element)
        new_all << element
      end
    end

    new_all == @collection
  end

  def count
    count = 0

    @collection.each do |element|
      new_count = yield(element)
      if new_count
        count += 1
      end
    end
    count
  end

  def find
    @collection.each do |element|
      new_find = yield(element)
      if new_find
        return element
      end
    end
    return nil
  end

  def each_with_index
    index = 0

    @collection.each do |element|
      yield(element, index)
      index += 1
    end
  end

  def drop(item)
    count = 0
    array = []

    @collection.each do |element|
      if count >= item
        array << element
      end
      count += 1
    end
    array
  end

  def drop_while
    new_array = []
    found_a_false = false

    @collection.each do |element|
      if !found_a_false && !yield(element)
        found_a_false = true
      end

      if found_a_false
        new_array << element
      end
    end

    return new_array
  end

  def drop_while
    index = 0

    @collection.each do |element|
      unless yield(element)
        return @collection[index..-1]
      end

      index += 1
    end

    return []
  end

  def drop_while
    each_with_index do |element, index|
      unless yield(element)
        return @collection[index..-1]
      end
    end
  end

  def find_index
    index = 0

    @collection.each do |element|
      if yield(element)
        return index
      end
      index += 1
    end
  end

  def include?(item)
    @collection.each do |element|
      if element == item
        return true
      end
    end
    return false
  end

  def map
    mapped_array = []

    @collection.each do |element|
      mapped_array << yield(element)
    end
    mapped_array
  end

  def max_by
    new_element = nil
    @collection.each do |element|
      if new_element.nil?
        new_element = element
      elsif yield(element) > yield(new_element)
        new_element = element
      end
    end
    new_element
  end

  def min_by
    new_element = nil
    @collection.each do |element|
      if new_element.nil?
        new_element = element
      elsif yield(element) < yield(new_element)
        new_element = element
      end
    end
    new_element
  end

  def reject
    result = []

    @collection.each do |element|
      unless yield(element)
        result << element
      end
    end

    return result
  end

  def reverse_each
    # Start the index at the end of the array
    index = @collection.size - 1

    # While we haven't run off the START of the array
    while index >= 0
      # Yield the element at that index
      yield @collection[index]
      # Back up the index by one
      index -= 1
    end

    @collection
  end

end
