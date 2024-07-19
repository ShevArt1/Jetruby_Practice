module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      command = gets.chomp
      break if command == 'q'

      if command =="GET" or command =="g"
        verb = "GET"
      elsif command =="POST" or command =="p"
        verb = "POST"
      elsif command =="PUT" or command =="u"
        verb = "PUT"
      elsif command =="DELETE" or command =="d"
        verb = "DELETE"
      else
        puts "No such method as #{command}"
        break
      end

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        act = gets.chomp
        break if act == 'q'
        if act =="index" or act =="i"
          action = "index"
        elsif act =="show" or act =="s"
          action == "show"
        else
          puts "No such method as #{act}"
          break
        end
      end


      puts action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    str = ""
    @posts.each_with_index do |post, index|
      str+= "#{index}: #{post}\n"
    end 
    str
  end

  def show
    puts 'Enter index'
    ind = gets.to_i
    if ind +1 <= @posts.size
      "#{ind}: #{@posts[ind]}"
    else
      "The requested post doesn't exist"
    end
  end

  def create
    puts 'Enter text'
    text = gets.chomp
    @posts<<text
    ind = @posts.size-1
    "#{ind}: #{@posts[ind]}"
  end

  def update
    puts 'Enter index'
    ind = gets.to_i
    if ind +1 <= @posts.size
      puts 'Enter text'
      text = gets.chomp
      @posts[ind] = text
      "#{ind}: #{@posts[ind]}"
    else
      "The requested post doesn't exist"
    end
  end

  def destroy
    puts 'Enter index'
    ind = gets.to_i
    if ind +1 <= @posts.size
      @posts.delete_at(ind)
      "post #{ind} deleted successfully"
    else
      "The requested post doesn't exist"
    end
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
    puts @routes[keyword]
  end
end

router = Router.new

router.init