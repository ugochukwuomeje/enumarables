# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  #-------------my each method----------------#
  def my_each
    return to_enum(:my_each) unless block_given?

    x = to_a
    count = 0
    yield(x[count]) while count < x.length
  end

  #----------------my each with index----------#
  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    x = to_a
    count = 0
    while count < x.length
      yield(count, x[count])
      count += 1
    end
  end

  #----------------#my_select-------------------#
  def my_select
    return to_enum(:my_each) unless block_given?

    x = to_a
    result = []
    position = 0
    x.my_each do |y|
      result << x[position] if yield(y)
    end
    result
  end

  #-------------------#my_all---------------------#
  def my_all
    return to_enum(:my_each) unless block_given?

    x = to_a
    result = true
    x.my_each do |y|
      result = false unless yield(y)
    end
    result
  end

  #-------------------#my_any---------------------#
  def my_any
    return to_enum(:my_each) unless block_given?

    x = to_a
    x.my_each do |y|
      return true if yield(y)
    end
    false
  end

  #-------------------#my_any---------------------#
  def my_none
    return to_enum(:my_each) unless block_given?

    x = to_a
    result = true
    x.my_each do |y|
      result = false if yield(y)
    end
    result
  end

  #------------------#none-------------------------#
  def my_count(param = nil)
    if block_given?
      count = 0
      to_a.my_each do |y|
        count += 1 if yield(y)
      end
      return count
    elsif !block_given? && param.nil?
      x.length
    else
      x.my_each { |num| count += 1 if num == param }
    end
    count
  end

  #----------#my_map-------------------------------#
  def my_map(my_proc = nil)
    x = to_a if self.class == Hash
    x = to_a if self.class == Range
    result = []
    if my_proc.nil? && block_given?
      x.my_each { |val| result << yield(val) }
    else
      x.my_each { |value| result << my_proc.call(value) }
    end
    result
  end

  #-------------#my_inject-------------------------#
  def my_inject(value = nil, operation = nil)
    x = to_a
    operation, value = operation.nil ? [value, nill] : [operation, value]
    if (value.nil? || value.class == Numeric) && (operation.class == Symbol) ||
       (operation.class == String) && !block_given?
      result, counter = value.nil ? [x[0], 1] : [value, 0]
      until counter >= x.length
        result = result.send(operation, x[counter])
        counter += 1
      end
      p result

    elsif block_given? && (value.nil || value.class == Numeric)
      result, counter = value.nil ? [x[0], 1] : [value, 0]
      until counter >= x.length
        result = yield(result, x[counter])
        counter += 1
      end
      p result
    end
  end
end

# 10.multiply_els
#------------------testing the inject method----------------------#
def multiply_els(arr)
  arr.my_inject('+')
end

multiply_els([2, 4, 5])
#--------------------testing the my_each method-------------------#
[2, 5, 8].my_each { |y| p y.to_s }

#------------testing each with index------------------------------#
[2, 5, 8].my_each_with_index { |index, value| p "The index is #{index} the value #{value}" }

#-------------testing the my_select method------------------------#
%w[bird cow goat leaves].my_select { |value| value.length > 4 }

#---------------------------testing my_all method-----------------#
[2, 4, 5, 'come', nil].my_all? { |value| value.class == Integer }

#----------------------------testing my_any method-----------------#
[2, 4, 5, 'come', nil].my_any? { |value| value.class == Integer }

#----------------------------testing my_none method-----------------#
[2, 4, 5, 'come', nil].none? { |value| value.class == Integer }

#----------------------------testing my_count-----------------#
[2, 4, 5, 'come', nil].count

#--------------------------my_map----------------------------#
even_numbers = proc.new(&:even?)

[2, 4, 5, 7, 8].my_map(even_numbers)

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
