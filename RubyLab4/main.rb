# require 'delegate'
# require 'date'
# class User
#   def born_on
#     Date.new(1989,9,10)
#   end
# end
# class UserDecorator < SimpleDelegator
#   def birth_year
#     born_on.year
#   end
# end

# user = User.new

# decorated_user = UserDecorator.new(user)
# puts decorated_user.birth_year
# puts decorated_user.born_on
# puts user.born_on.year

require './CashMachine.rb'

CashMachine.init