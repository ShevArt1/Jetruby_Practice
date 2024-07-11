def greeting
    puts "Введите свое имя"
    name = gets.chomp
    puts "Введите свою фамилию"
    surname = gets.chomp
    puts "Введите свой возраст"
    age = gets.to_i

    while age <=0 
        puts "Возраст указан некорректно. Попробуйте снова."
        age = gets.to_i
    end
    
    unless age <18
        "Привет #{name} #{surname}. Самое время заняться делом."
    else
        "Привет #{name} #{surname}. Тебе меньше 18 лет, но писать багованный код никогда не рано."
    end
end

def foobar(a, b)

    if a.is_a? Numeric and b.is_a? Numeric
        if a==20 || b==20
            b
        else
            a+b
        end
    else 
        "non numeric values found"
    end
end