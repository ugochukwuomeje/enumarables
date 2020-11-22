# frozen_string_literal: false

module Enumerables
  #-------------my each method----------------#
  def my_each
    # your code here
    for x in tools
      yield(x)
    end
  end

  #----------------my each with index----------#
  def my_each_with_index
    count = 0;
    for x in tools
      yield(count, x)
      count = count +1
    end 
  end

  #----------------#my_select-------------------#
  def my_select
    result = []
    for x in tools
      if(yield(x))
        result << x
      end
    end
    result
  end
  
end
