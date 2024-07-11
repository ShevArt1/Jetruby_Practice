require 'rspec'
require './methods.rb'

RSpec.describe "rubyFirst" do

    it "#greeting" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Art", "Shev", 21)
        expect(greeting).to eq("Привет Art Shev. Самое время заняться делом.")
    end

    it "#greeting" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Sanya", "Ivanov", 15)
        expect(greeting).to eq("Привет Sanya Ivanov. Тебе меньше 18 лет, но писать багованный код никогда не рано.")
    end

    it "#greeting" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Sanya", "Ivanov", "qwerty", 0, 3)
        expect(greeting).to eq("Привет Sanya Ivanov. Тебе меньше 18 лет, но писать багованный код никогда не рано.")
    end

end

RSpec.describe "rubyFirst" do
    it "foobar" do
    
        expect(foobar(20, 7)).to eq(7)
    end

    it "foobar" do
    
        expect(foobar(12, 20)).to eq(20)
    end

    it "foobar" do
    
        expect(foobar(2, 17)).to eq(19)
    end

    it "foobar" do
    
        expect(foobar('a', 17)).to eq("non numeric values found")
    end

    it "foobar failure example" do
    
        expect(foobar(20, 9)).to eq(20)
    end
end