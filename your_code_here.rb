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
      all = yield(element)
      if all
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
        count +=1
      end
    end
    count
  end
end
