class FileMaster
    def initialize(path, buffer)
        @path = path
        @buffer = buffer
    end

    def index
        File.foreach(@path){|word| puts word}
    end
    
    def find(id)
        a = 'Warning! The line is not found, try using another id'
        File.foreach(@path).with_index do |word, index|
            if id == index
                a = word
            end
        end
        a
    end
    
    def where(pattern)
        arr_of_id = []
        File.foreach(@path).with_index do |word, index|
            if word.include?(pattern)
                arr_of_id << index 
            end
        end
        arr_of_id
    end
    
    def update(id, name)
        file = File.open(@buffer, 'w')
        File.foreach(@path).with_index do |word, index|
            file.puts(id == index ? name : word)
        end
        file.close
        File.write(@path, File.read(@buffer))
        File.delete(@buffer) if File.exist?(@buffer)
    end
    
    def delete(id)
        file = File.open(@buffer, 'w')
        File.foreach(@path).with_index do |word, index|
            if id!= index
                file.puts(word)
            end
        end
        file.close
        File.write(@path, File.read(@buffer))
        File.delete(@buffer) if File.exist?(@buffer)
    end
    
    
    def create(name)
        File.write(@path, name.to_s, mode: "a")
    end


end
