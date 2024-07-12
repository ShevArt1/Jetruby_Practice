require './methods.rb'

puts "Enter 1 to work with students file, enter anything else to access ATM "
number_of_task = gets.to_i
if number_of_task ==1
    student_list
else
    bank
end
