require 'rspec'
require './methods.rb'
require './FileMaster.rb'

RSpec.describe "CRUD in files. FileMaster methods test" do
    subject do 
      FileMaster.new("methods_test.txt", "buffer_test.txt")
    end
    before do
        file = File.open("methods_test.txt", "w")
        file.write("line 1\r\nline 2\r\nline 3\r\nstring 1\r\nstring 2\r\nstring 3\r\n")
        file.close()
    end
  
    it "index" do
        expect{ subject.index }.to output("line 1\r\nline 2\r\nline 3\r\nstring 1\r\nstring 2\r\nstring 3\r\n").to_stdout
    end

    it "find" do
        expect(subject.find(0)).to eq("line 1\r\n")
      end

    it "find failing" do
      expect(subject.find(8)).to eq("Warning! The line is not found, try using another id")
    end
  
    it "where" do
      expect(subject.where("string")).to eq([3, 4, 5])
    end

    it "where again" do
        expect(subject.where("3")).to eq([2, 5])
      end
  
    it "update" do 
      subject.update(0, "first line")
      expect(subject.find(0)).to eq("first line\n")
    end
  
    it "delete" do
      subject.delete(0)
      expect(subject.find(0)).to eq("line 2\r\n")
    end
  
    it "create" do
      subject.create("new line")
      expect(subject.find(6)).to eq("new line")
    end
  
    after{File.delete("methods_test.txt")}
  end 

RSpec.describe "student_list" do
    it "ask new age until -1 entered" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return('23', '2', '21', '-1')
        student_list
        expect(File.read("results.txt")).to eq("Семен Семенов 23\r\nМакар Макаров 23\r\nПетр Петров 21\r\nАртем Шевякин 21\r\nВладислав Романов 21\r\n")
    end

    it "ask new age until all students are in the list" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return('21', '22', '19', '23', '22', '20')
        student_list
        expect(File.read("results.txt")).to eq("Петр Петров 21\r\nАртем Шевякин 21\r\nВладислав Романов 21\r\nСтепан Степанов 22\r\nАлександр Александров 22\r\nАндрей Андреев 19\r\nСемен Семенов 23\r\nМакар Макаров 23\r\nСтепан Степанов 22\r\nАлександр Александров 22\r\nИван Иванов 20\r\nАнтон Антонов 20\r\n")
    end

end 


BANK = "balance_test.txt"

RSpec.describe "bank" do
    context "file contains correct value" do
        before do
            file = File.open("balance_test.txt", "w")
            file.write("69.0")
            file.close()
        end

        it "init with deposit" do
            allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '41', 'q')
            bank
            expect(File.read("balance_test.txt").strip).to eq("110.0")
        end

        it "init with withdraw" do
            allow_any_instance_of(Kernel).to receive(:gets).and_return('w', '29.1', 'q')
            bank
            expect(File.read("balance_test.txt").strip).to eq("39.9")
        end


        it "trying again after failing withdrawal and deposit" do
            allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '0', 'whatever', '10', 'w', '-20', 'something', '9', 'Q')
            bank
            expect(File.read("balance_test.txt").strip).to eq("70.0")
        end

        it "using predetermined deposits and trying to withdraw more than current balance" do
            allow_any_instance_of(Kernel).to receive(:gets).and_return('D', 'a', 'W', '200', '169', 'w', 'D', 'c', 'q')
            bank
            expect(File.read("balance_test.txt").strip).to eq("1000.0")
        end

        it "receiving non-existant commands" do
            allow_any_instance_of(Kernel).to receive(:gets).and_return('w', '10', 'wldn', 'w', '10', '2dmeceo', 'Q')
            bank
            expect(File.read("balance_test.txt").strip).to eq("49.0")
        end

        after do
            File.delete("balance_test.txt")
        end
    end

    context "file does not exist" do
        it "uses default value if file doesn't exist" do
            allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '200', 'q')
            bank
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
            bank
            expect(File.read("balance_test.txt").strip).to eq("300.0")
        end
        
        
        after do
            File.delete("balance_test.txt")
        end
    end
end

