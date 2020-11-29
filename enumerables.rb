# frozen_string_literal: false

module Enumerables
  #-------------my each method----------------#
  def my_each
    return to_enum(:my_each) unless block_given?
    # your code here
    x = self.to_a if self.class? == Array
    x = self.to_a if self.class? ==  Range

    for x in self
      yield(x)
    end
  end

  #----------------my each with index----------#
  def my_each_with_index
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class? == Array
    x = self.to_a if self.class? ==  Range
    count = 0;
    for x in self
      yield(count, x)
      count = count +1
    end 
  end

  #----------------#my_select-------------------#
  def my_select
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class? == Array
    x = self.to_a if self.class? ==  Range
    result = []
    for x in self
      if(yield(x))
        result << x
      end
    end
    result
  end
  
  #-------------------#my_all---------------------#
  def my_all
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class? == Array
    x = self.to_a if self.class? ==  Range
    result = true
    for x in self
      if(!yield(x))
        result = false
      end
    end
    result
  end

  #-------------------#my_any---------------------#
  def my_any
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class? == Array
    x = self.to_a if self.class? ==  Range
    result = false
    for x in self
      if(yield(x))
        result = true
      end
    end
    result
  end

  #-------------------#my_any---------------------#
  def my_none
    return to_enum(:my_each) unless block_given?
    x = self.to_a if self.class? == Array
    x = self.to_a if self.class? ==  Range
    result = true
    for x in self
      if(yield(x))
        result = false
      end
    end
    result
  end

end

[2,3,5,8].my_each {|numbers| puts numbers}