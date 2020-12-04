# frozen_string_literal: false

module Enumerable
  #-------------my each method----------------#
  def my_each
    return to_enum(:my_each) unless block_given?
    # your code here
    x = self.to_a if self.class == Hash
    x = self.to_a if self.class ==  Range

    for y in x
      yield(y)
    end
    
  end

  #----------------my each with index----------#
  def my_each_with_index
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class == Hash
    x = self.to_a if self.class ==  Range
    count = 0;
    for y in x
      yield(count, y)
      count = count +1
    end 
  end

  #----------------#my_select-------------------#
  def my_select
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class == Hash
    x = self.to_a if self.class ==  Range
    result = []
    position = 0
    for y in x
      if(yield(y))
        result << x[position]
      end
    end
    result
  end
  
  #-------------------#my_all---------------------#
  def my_all
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class == Hash
    x = self.to_a if self.class ==  Range
    result = true
    for y in x
      if(!yield(y))
        result = false
      end
    end
    result
  end

  #-------------------#my_any---------------------#
  def my_any
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class == Hash
    x = self.to_a if self.class ==  Range
    for y in x
      if(yield(y))
       return  true
      end
    end
    return false
  end

  #-------------------#my_any---------------------#
  def my_none
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class == Hash
    x = self.to_a if self.class ==  Range
    result = true
    for y in x
      if(yield(y))
        result = false
      end
    end
    result
  end

  #------------------#none-------------------------#
  def my_count(param = nil)
    
  if block_given?
    count = 0;
    x = self.to_a if self.class == Hash
    x = self.to_a if self.class ==  Range
      for y in x
        if(yield(y))
          count = count + 1
        end
      end
        return count
    elsif !block_given? and param == nil
      x.length
    else
      x.my_each { |num| count +=1 if num == param}
    end
      return count
end

#----------#my_map-------------------------------#
def my_map(my_proc = nil)
  
    x = self.to_a if self.class == Hash
    x = self.to_a if self.class ==  Range
    result = []
    if(my_proc.nil? && block_given?)
      x.my_each {|val| result << yield(val)}
    else
      x.my_each{|value| result << my_proc.call(value)}
    end
  result
end

  #-------------#my_inject-------------------------#
  def my_inject(value = nil, operation = nil)

    if (self.class == Range )
      x = self.to_a 
    else
      x = self
    end
    
    if(operation.nil? && ((value.class == Symbol) ||(value.class == String) && !block_given?))
      counter = 1
      operation = value
      value = nil
      until  counter >= (x.length) do
        if(counter == 1)
          result = x[0].send(operation, x[1])
        else
          result = result.send(operation, x[counter])
        end
        counter+=1
      end
     p result
    elsif(!value.nil? && ((operation.class == Symbol) ||(operation.class == String) && !block_given?))
      counter = 0
      result = value
      until  counter >= (x.length) do
          result = result.send(operation, x[counter])
          counter+=1
      end
    p result
    
    elsif(!value.nil? && block_given?)
        counter = 0
        result = value
        until  counter >= (x.length)
            result = yield(result, x[counter])
            counter+=1
        end
        p result
    
    elsif(value.nil? && block_given?)
      counter = 1
      until  counter >= (x.length) do
        if(counter == 1)
          result = yield(x[0], x[1])
        else
          result = yield(result, x[counter])
        end
        counter+=1
      end
        p result
    end
  end
    # if(value.class == Hash)
    #   counter = 0
    #   result = value
    #   until  counter >= (x.length)
    #       result = yield(result, x[counter])
    #       counter+=1
    #   end
    #  p result
    # end
end

# 10.multiply_els
#------------------testing the inject method----------------------#
def multiply_els(arr)
  arr.my_inject("+")
end

multiply_els([2, 4, 5])
#--------------------testing the my_each method-------------------#
[2,5,8].my_each{|y| p "#{y}" }

#------------testing each with index------------------------------#
[2,5,8].my_each_with_index{|index, value| p "The index is #{index} the value #{value}" }

#-------------testing the my_select method------------------------#
%w[bird cow goat leaves].my_select{|value| value.length > 4}

#---------------------------testing my_all method-----------------#
[2,4,5,"come", nil].my_all?{|value| value.class == Integer}

#----------------------------testing my_any method-----------------#
[2,4,5,"come", nil].my_any?{|value| value.class == Integer}

#----------------------------testing my_none method-----------------#
[2,4,5,"come", nil].none?{|value| value.class == Integer}

#----------------------------testing my_count-----------------#
[2,4,5,"come", nil].count

#--------------------------my_map----------------------------#
evenNumbers = proc.new {
  |value| value.even?
}

[2,4,5,7, 8].my_map(evenNumbers)