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

  def drop(argument)
    count = 0
    array = []

    @collection.each do |element|
      if count >= argument
        array << element
      end
      count += 1
    end
    array
  end

  def drop_while
    array = []

    @collection.each do |element|
      if yield(element)
        array << element
      end
    end
    array
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

  def include?(argument)
    @collection.each do |element|
      if element == argument
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
end
