require 'rack'
require './CashMachine.rb'
DEFAULT = 100.0
BANK = "balance.txt"
class App

  def file_connect
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
    cur
  end
  def initialize  
    @atm = CashMachine.new(BANK, file_connect)
  end
  def call(env)
    req = Rack::Request.new(env)
    params = req.query_string.split("&").map{|pair| pair.split("=")}.to_h
    router(req.path, params) 
  end

  def router(path, params)
    case path
    when '/'
      [200, {'Content-Type' => 'text/html'}, File.readlines('./index.html')]
    when '/deposit'
      result = dep_controller(params)
      [200, {'Content-Type' => 'text/html'}, [result]]
    when '/withdraw'
      result =wit_controller(params)
      [200, {'Content-Type' => 'text/html'}, [result]]
    when '/balance'
      result =@atm.Balance
      [200, {'Content-Type' => 'text/html'}, [result]]
    when '/quit'
      result = @atm.Quit
      [200, {'Content-Type' => 'text/html'}, [result]]
    else
      [404, {'Content-Type' => 'text/html'}, ['<p>Entered non-existent command. Try again OR</p><a href="http://localhost:3000">return to command list</a>']]
    end
    
  end
  
  def wit_controller(params)
    val = params["value"].to_f
    if @atm.current == 0.0
      '<p>You have no money on the balance <a href="http://localhost:3000">return to command list</a>'
    elsif val <=0
      '<p>Incorrect sum for withdrawal. Use positive number OR</p><a href="http://localhost:3000">return to command list</a>'
    elsif val >@atm.current
      '<p>You don\'t have requested sum on the balance. Try smaller number OR</p><a href="http://localhost:3000">return to command list</a>'
    else 
      @atm.Withdraw(val)
    end
  
  end

  def dep_controller(params)
    case params["value"]
    when "a"
      @atm.Deposit(100)
    when "b"
      @atm.Deposit(500)
    when "c"
      @atm.Deposit(1000)
    else 
      val = params["value"].to_f
      if val <=0.0
        '<p>Incorrect sum for deposit. Try another number OR</p><a href="http://localhost:3000">return to command list</a>'
      else
        @atm.Deposit(val)
      end 
    end
  
  end



end