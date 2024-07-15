class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
  end

  def run
    puts '-' * 30
    puts "Welcome to the MVC Food Delivery App"
    puts '-' * 30
    puts

    loop do
      puts '-' * 30
      puts "What would you like to do?"
      puts "1. List all the meals"
      puts "2. Add a meal"
      puts "3. List all the customers"
      puts "4. Add a customer"
      puts "0. Exit the app"
      puts '-' * 30
      print '> '
      action = gets.chomp.to_i

      case action
      when 1 then @meals_controller.list
      when 2 then @meals_controller.add
      when 3 then @customers_controller.list
      when 4 then @customers_controller.add
      when 0 then break
      else puts "Please select a valid option"
      end
    end
  end
end