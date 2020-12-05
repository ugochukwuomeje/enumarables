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
