require 'rack/test'
require './App'
RSpec.describe App do
  include Rack::Test::Methods

  def app
    App.new
  end
  
  describe 'GET /' do
    it 'returns the index page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include("EXISTING COMMANDS")
    end
  end

  describe 'GET /balance' do
    it 'returns the current balance' do
      get '/balance'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Your current balance is")
    end
  end

  describe 'GET /deposit' do
    it 'deposits the specified amount' do
      get '/deposit?value=100'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Deposit completed successfully")
    end

    it 'deposits the chosen amount' do
      get '/deposit?value=b'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Deposit completed successfully")
    end

    it 'returns an error for invalid amount' do
      get '/deposit?value=-100'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Incorrect sum for deposit")
    end
  end

  describe 'GET /withdraw' do
    it 'withdraws the specified amount' do
      get '/withdraw?value=50'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Withdrawal completed successfully")
    end

    it 'returns an error for invalid amount' do
      get '/withdraw?value=-50'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Incorrect sum for withdrawal")
    end

    it 'returns an error for insufficient funds' do
      get '/withdraw?value=1000'
      expect(last_response).to be_ok
      expect(last_response.body).to include("You don't have requested sum on the balance")
    end
  end

  describe 'GET /quit' do
    it 'saves the current balance' do
      get '/quit'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Balance is saved")
    end
  end

end


# RSpec.describe CashMachine do
#   let(:bank_file) { 'test_balance.txt' }
#   let(:initial_balance) { 100.0 }
#   let(:atm) { CashMachine.new(bank_file, initial_balance) }

#   before do
#     File.write(bank_file, initial_balance)
#   end

#   after do
#     File.delete(bank_file) if File.exist?(bank_file)
#   end

#   describe '#Deposit' do
#     it 'increases the balance by the given amount' do
#       expect(atm.Deposit(50)).to eq("Deposit completed successfully, current balance is 150.0")
#       expect(atm.current).to eq(150.0)
#     end
#   end

#   describe '#Withdraw' do
#     it 'decreases the balance by the given amount' do
#       expect(atm.Withdraw(50)).to eq("Withdrawal completed successfully. Your current balance is 50.0")
#       expect(atm.current).to eq(50.0)
#     end

#     it 'returns an error message for insufficient funds' do
#       expect(atm.Withdraw(150)).to eq("You don't have requested sum on the balance. Try smaller number OR")
#       expect(atm.current).to eq(100.0)
#     end
#   end

#   describe '#Balance' do
#     it 'returns the current balance' do
#       expect(atm.Balance).to eq("Your current balance is 100.0")
#     end
#   end

#   describe '#Quit' do
#     it 'saves the current balance to the file' do
#       atm.Deposit(50)
#       atm.Quit
#       expect(File.read(bank_file).to_f).to eq(150.0)
#     end
#   end
# end