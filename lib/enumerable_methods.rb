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
      my_each do |x|
        count += 1 if yield(x) == true
      end
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
    self.my_each do |x|
      if memo == nil
        memo = self[0]
        next
      end
      memo = yield(memo, x)
    end
    memo
  end

  def multiply_els
    self.my_inject { |x, y| x * y}
  end

end

arr = ['potato', 'ball', 'carrot', 'disc']
n_arr = [1, 2, 3, 4, 5, 3]
hsh = {
  name: 'Toti',
  age: 29,
  skills: 'non existent'
}

# idx = 0
# until idx == arr.length
#   puts arr[idx]
#   idx += 1
# end
# hsh.my_each { |x, y| puts "This item of the array is #{y}"}
# hsh.each { |x, y| puts "This item of the array is #{x}"}
# hsh.my_each_with_index { |(k ,v), index| puts "they key is #{k} and value is #{v} and this is the number #{index + 1} item from the list."}
# arr.my_second_each do |x|
#   puts "this is #{x}"
# end
# arr.each { |x| puts "this is #{x}" }
# n_arr.my_select { |x| x > 3 }
# n_arr.my_none? { |x| x > 3 }
# arr.map { |x| x *2 }
# n_arr.multiply_els
# my_proc = Proc.new { |x| x * 2}
# n_arr.my_map { |x| x * 3 }