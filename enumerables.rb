# frozen_string_literal: false

module Enumerables
  #-------------my each method----------------#
  def my_each
    # your code here
    for x in tools
      yield(x)
    end
  end

end
