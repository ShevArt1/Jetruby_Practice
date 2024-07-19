
class CashMachine

  attr_accessor :current
  def initialize(bank, cur)
      @bank = bank
      @current = cur
  end
  

  def Deposit(value)
    @current += value
    "Deposit completed successfully, current balance is #{@current}"      
  end 

  def Withdraw(value)
    @current -= value
    "Withdrawal completed successfully. Your current balance is #{@current}" 
  end

  def Balance
    "Your current balance is #{@current}"
  end

  def Quit
    File.write(@bank, @current)
    '<p>Balance is saved</p><a href="http://localhost:3000">RETURN TO COMMAND LIST</a>'
  end

end
