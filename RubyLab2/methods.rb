def word_scan(word)
    if (word[-2]=='c' || word[-2]=='C') && (word[-1]=='s' || word[-1]=='S')
        2**word.size
    else
        word.reverse
    end
end

def pokemon
    arr =[]
    puts "How many pokemons you want ?"
    n = gets.to_i
    while n<=0
        puts "GIVE ME A POSITIVE NUMBER"
        n = gets.to_i
    end

    n.times do
        puts "Who's that pokemon ?"
        pok_name = gets.chomp
        puts "What color it is ?"
        pok_color = gets.chomp


        arr<<{name: pok_name, color: pok_color}
    end
    arr
end