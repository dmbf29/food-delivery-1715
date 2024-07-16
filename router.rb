class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
  end

  def run
    puts '-' * 30
    puts "Welcome to the MVC Food Delivery App"
    puts '-' * 30
    puts
    @employee = @sessions_controller.log_in
    while @employee
      if @employee.manager?
        display_menu_manger
        print '> '
        action = gets.chomp.to_i
        actions_manager(action)
      else
        display_menu_rider
        print '> '
        action = gets.chomp.to_i
        actions_rider(action)
      end
    end
  end

  def display_menu_manger
    puts "1. List all the meals"
    puts "2. Add a meal"
    puts "3. List all the customers"
    puts "4. Add a customer"
    puts "0. Exit the app"
  end

  def actions_manager(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 0 then log_out
    else puts "Please select a valid option"
    end
  end

  def actions_rider(action)
    case action
    when 0 then log_out
    else puts "Please select a valid option"
    end
  end

  def display_menu_rider
    puts "1. TODO"
    puts "0. Exit the app"
  end

  def log_out
    @employee = nil
  end
end
