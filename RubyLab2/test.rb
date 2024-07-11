require 'rspec'
require './methods.rb'

RSpec.describe "rubySecond" do
    it "word_scan" do
    
        expect(word_scan("Cs")).to eq(4)
    end

    it "word_scan" do
    
        expect(word_scan("skWDbAlcS")).to eq(512)
    end

    it "word_scan" do
    
        expect(word_scan("qwerty")).to eq("ytrewq")
    end
end


RSpec.describe "rubySecond" do

    it "pokemon" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(1, "Pikachu", "Yellow")
        expect(pokemon).to eq([{name: "Pikachu", color: "Yellow"}])
    end

    it "pokemon" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(3, "Totodile", "Cyan", "Hoothoot", "Beige", "Banette", "Black")
        expect(pokemon).to eq([{name: "Totodile", color: "Cyan"},{name: "Hoothoot", color: "Beige"},{name: "Banette", color: "Black"}])
    end

    it "pokemon" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("hi", 0, 1, "Charizard", "Orange")
        expect(pokemon).to eq([{name: "Charizard", color: "Orange"}])
    end

end