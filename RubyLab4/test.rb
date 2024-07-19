require 'rspec'
require './CashMachine.rb'
BANK = "balance_test.txt"

RSpec.describe "CashMachine" do
  context "file contains correct value" do
    before do
      file = File.open("balance_test.txt", "w")
      file.write("69.0")
      file.close()
    end

    it "init with deposit" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '41', 'q')
      CashMachine.init
      expect(File.read("balance_test.txt").strip).to eq("110.0")
    end

    it "init with withdraw" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('w', '29.1', 'q')
      CashMachine.init
      expect(File.read("balance_test.txt").strip).to eq("39.9")
    end

    it "choosing another action after failing withdrawal and deposit" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '0', 'E', 'w', 'wjkd', 'e', 'Q')
      CashMachine.init
      expect(File.read("balance_test.txt").strip).to eq("69.0")
    end

    it "trying again after failing withdrawal and deposit" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '0', 'whatever', '10', 'w', 'wjkd', 'something', '9', 'Q')
      CashMachine.init
      expect(File.read("balance_test.txt").strip).to eq("70.0")
    end

    it "using predetermined deposits and trying to withdraw more than current balance" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('D', 'a', 'W', '200', 'j', '169', 'w', 'D', 'c', 'q')
      CashMachine.init
      expect(File.read("balance_test.txt").strip).to eq("1000.0")
    end

    it "receiving non-existant commands" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('w', '10', 'wldn', 'w', '10', '2dmeceo', 'Q')
      CashMachine.init
      expect(File.read("balance_test.txt").strip).to eq("49.0")
    end

    after do
      File.delete("balance_test.txt")
    end
  end

  context "file does not exist" do
    it "uses default value if file doesn't exist" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '200', 'q')
      CashMachine.init
      expect(File.read("balance_test.txt").strip).to eq("300.0")
    end
  
  
    after do
      File.delete("balance_test.txt")
    end
  end
  
  context "file does not contain value" do
    before do
      file = File.open("balance_test.txt", "w")
      file.write("haha, there is no money! only words")
      file.close()
    end
  
    it "uses default value if file contains non-numeric data" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '200', 'q')
      CashMachine.init
      expect(File.read("balance_test.txt").strip).to eq("300.0")
    end
  
  
    after do
      File.delete("balance_test.txt")
    end
  end
end


