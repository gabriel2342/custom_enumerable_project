module Enumerable
  # Your code goes here
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    index = 0
    while index < self.size
      yield self[index]
      index+=1
    end
    self
  end

  def my_each_with_index
    index = 0
    while index < self.size
      yield self[index], index
      index+=1
    end
    self
  end

  def my_select
    arr = []
    hsh = {}
    self.my_each do |element|
      if yield element
        self.is_a?(Array) ? arr.push(element) : hsh.store(element[0], element[1])
      end
    end
    return arr if hsh.empty?
    hsh
  end

  def my_all?
    any_false = true
    self.my_each do |element|
      if yield element 
        next
      else 
        any_false = false
      end
    end 
    any_false
  end 

  def my_none?
    no_true = true
    self.my_each do |element|
      no_true = false if yield element
    end
    no_true
  end
  
  def my_count
    count = 0
    size = 0
    return self.size if block_given? == false
    self.my_each do |element|
      if yield element
        count += 1
        no_true = false
      end 
    end
    count
  end

  def my_map 
    arr = []
    self.my_each do |element|
      arr.push(yield element)
    end
    arr
  end

  def my_inject(value)
    accumulator=value
    my_each { |element| accumulator = yield(element, accumulator) }
    accumulator
  end

end

