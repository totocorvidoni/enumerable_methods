module Enumerable

  def my_each
    return to_enum(__method__) unless block_given?
    i = 0
    until i == length
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(__method__) unless block_given?
    i = 0
    until i == length
      yield self[i], i
      i += 1
    end
    self
  end

  # I needed to figure out how to pass the parameters of yield inside each
  # def my_second_each
  #   self.my_each { |x| yield x }
  # end

  def my_select
    return to_enum(__method__) unless block_given?
    result = []
    my_each do |x|
      result << x if yield(x)
    end
    result
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |x| return false if yield(x) == false }
    elsif !pattern.nil?
      my_each { |x| return false unless pattern === x }
    else
      my_each { |x| return false if x == false || x.nil? }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |x| return true if yield(x) == true }
    elsif !pattern.nil?
      my_each { |x| return true if pattern === x }
    else
      my_each { |x| return true unless x == false || x.nil? }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |x| return false if yield(x) == true }
    elsif !pattern.nil?
      my_each { |x| return false if pattern === x }
    else
      my_each { |x| return false unless x == false || x.nil? }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |x| count += 1 if yield(x) == true }
    elsif arg.nil?
      count = length
    else
      my_each { |x| count += 1 if arg === x }
    end
    count
  end

  def my_map(&block)
    return to_enum(__method__) unless block_given?
    result = []
    i = 0
    until i == length
      result << yield(self[i])
      i += 1
    end
    result
  end

  def my_inject(memo = nil)
    my_each do |x|
      if memo.nil?
        memo = self[0]
        next
      end
      memo = yield(memo, x)
    end
    memo
  end

  def multiply_els
    my_inject { |x, y| x * y}
  end
end
