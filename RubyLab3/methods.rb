

require './FileMaster.rb'
#task 2 - students 
STUD = "students.txt"
BUFF = "buffer.txt"
RES = "results.txt"

def student_list
    File.write(RES, "")
    students = FileMaster.new(STUD, BUFF)
    results = FileMaster.new(RES, BUFF)
    used = []
    File.foreach(STUD){used<<0}
    while (used.min ==0)
        puts "Enter student's age. Enter -1 to finish!"
        age = gets.to_i
        break if age==-1
        # students are usually older :)
        # but really, to avoid accessing age 19 by typing 9 for example
        # also doesn't allow using letters instead of age
        if age >10
            found = students.where(age.to_s)
            found.each do |student|
                results.create(students.find(student))
                used[student] =1
            end
        end
    end

puts"\nRESULT:"
results.index
end
    
# task 3 - balance checking
BANK = "balance.txt"
DEFAULT = 100.0

def bank
    
    if File.exist?(BANK)
        file_data = File.read(BANK)
        a = file_data.to_f
        if a == 0.0
            if file_data =="0.0"
                current = 0.0
            else 
                current = DEFAULT
            end
        else
            current = a
        end
    else 
        current = DEFAULT
    end
    
    puts "Hello, let's start by using one of the commands: Deposit, Withdraw, Balance or Quit"
    command = gets.chomp

    while (command !="Q" and command != "q")
        if command =='D' or command == 'd'
            puts "Enter a sum that you would like to deposit or use one of predetermined options"
            puts "a - deposit 100.0, b - deposit 500.0, c - deposit 1000.0"
            deposit= gets.chomp
            if deposit == "a"
                current += 100.0
            elsif deposit == "b"
                current += 500.0
            elsif deposit == "c"
                current += 1000.0
            else
                while (deposit.to_f <=0.0 )
                    puts "Incorrect sum for deposit. Try entering a number that is larger than zero"
                    deposit = gets.to_f
                end
                current +=deposit.to_f
            end
            puts "Deposit completed successfully, current balance is #{current}"
        elsif command =='W' or command == 'w'
            if current == 0.0
                puts "There is no money on your balance. Please choose a different command" 
            else
                puts "Enter how much money you want to withdraw"
                withdraw = gets.to_f
                while (withdraw <=0.0 or withdraw >current)
                    puts "The requested sum can't be accessed. Try entering another number"
                    withdraw =gets.to_f
                end
                current -= withdraw
                puts "Withdrawal completed successfully. Your current balance is #{current}"
            end
        elsif command =='B' or command == 'b'
            puts "Your current balance is #{current}"
        else
            puts "Error! Entered non-existent command. Use D, W, B or Q (in upper- or lowercase)"
        end
        puts "Enter a command to continue"
        command = gets.chomp
    end
    File.write(BANK, current)

end
