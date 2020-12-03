# frozen_string_literal: false

module Enumerables
  #-------------my each method----------------#
  def my_each
    return to_enum(:my_each) unless block_given?
    # your code here
    x = self.to_a if self.class? == Hash
    x = self.to_a if self.class? ==  Range

    for y in x
      yield(y)
    end
  end

  #----------------my each with index----------#
  def my_each_with_index
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class? == Hash
    x = self.to_a if self.class? ==  Range
    count = 0;
    for y in x
      yield(count, y)
      count = count +1
    end 
  end

  #----------------#my_select-------------------#
  def my_select
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class? == Hash
    x = self.to_a if self.class? ==  Range
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
    x = self.to_a if self.class? == Hash
    x = self.to_a if self.class? ==  Range
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
    x = self.to_a if self.class? == Hash
    x = self.to_a if self.class? ==  Range
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
    x = self.to_a if self.class? == Hash
    x = self.to_a if self.class? ==  Range
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
    x = self.to_a if self.class? == Hash
    x = self.to_a if self.class? ==  Range
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
      return count
end


#[2,3,5,8].