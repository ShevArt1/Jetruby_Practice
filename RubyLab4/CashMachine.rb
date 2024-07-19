DEFAULT = 100.0
BANK = "balance.txt"
class CashMachine

  attr_accessor :current
  def initialize(bank, cur)
      @bank = bank
      @current = cur
  end
  
  def self.init
    
    if File.exist?(BANK)
      file_data = File.read(BANK)
      a = file_data.to_f
      if a == 0.0
          if file_data =="0.0"
              cur = 0.0
          else 
              cur = DEFAULT
          end
      else
          cur = a
      end
    else 
      cur = DEFAULT
    end

    atm = CashMachine.new(BANK, cur)
    puts "Hello, let's start by using one of the commands: Deposit, Withdraw, Balance or Quit"
    atm.command
    
    
  end

  def command
    puts "Please enter the command to continue"
    action = gets.chomp
    if action.downcase =="d"
      self.Deposit
      self.command
    elsif action.downcase =="w"
      self.Withdraw
      self.command
    elsif action.downcase =="b"
      self.Balance
      self.command
    elsif action.downcase =="q"
      self.Quit
    else
      puts "Error! Entered non-existent command. Use D, W, B or Q (in upper- or lowercase)"
      self.command
    end
    
  end

  def Deposit
    puts "Enter a sum that you would like to deposit or use one of predetermined options"
          puts "a - deposit 100.0, b - deposit 500.0, c - deposit 1000.0"
          deposit= gets.chomp
          if deposit == "a"
              @current += 100.0
              puts "Deposit completed successfully, current balance is #{@current}"
          elsif deposit == "b"
              @current += 500.0
              puts "Deposit completed successfully, current balance is #{@current}"
          elsif deposit == "c"
              @current += 1000.0
              puts "Deposit completed successfully, current balance is #{@current}"
          elsif (deposit.to_f <=0.0 )
              puts "Incorrect sum for deposit. Enter e to go back to command selection or anything else to try again"
              choise = gets.chomp
              unless choise.downcase=="e"
                puts "Hint: Try entering a NUMBER that is larger than zero"
                self.Deposit
              end
          else
              @current +=deposit.to_f
              puts "Deposit completed successfully, current balance is #{@current}"
          end
  end 

  def Withdraw
    if @current == 0.0
      puts "There is no money on your balance. Please choose a different command" 
    else
      puts "Enter how much money you want to withdraw"
      withdraw = gets.to_f
      
      if (withdraw <=0.0 or withdraw >current)
        puts "The requested sum can't be accessed. Enter e to go back to command selection or anything else to try again"
        choise = gets.chomp
        unless choise.downcase=="e"
          self.Withdraw
        end
      else
        @current -= withdraw
        puts "Withdrawal completed successfully. Your current balance is #{@current}"
      end
    end
  end

  def Balance
    puts "Your current balance is #{@current}"
  end

  def Quit
    File.write(@bank, @current)
  end

end


