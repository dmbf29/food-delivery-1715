require_relative '../views/employee_view'
require_relative '../views/order_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @employee_view = EmployeeView.new
    @order_view = OrderView.new
  end

  def list_undelivered_orders
    # get the orders from the repository
    orders = @order_repository.undelivered_orders
    # give those orders to the view
    @order_view.display(orders)
  end

  def list_my_undelivered_orders(employee)
    # get my orders from the repository
    orders = @order_repository.my_undelivered_orders(employee)
    # give those orders to the view
    @order_view.display(orders)
  end

  def mark_as_delivered(employee)
    # get my orders from the repository
    orders = @order_repository.my_undelivered_orders(employee)
    # give those orders to the view
    @order_view.display(orders)
    # we need a number from the view for the order (index)
    index = @order_view.ask_for('number').to_i - 1
    # user the index to get the one order
    order = orders[index]
    # mark it as delivered
    @order_repository.mark_as_delivered(order)
  end

  def add
    # get the meals from the meal repository
    # tell the view to display the meals
    # ask the user for the number of the meal
    # get the meal using the index on the meals array
    meals = @meal_repository.all
    @meal_view.display(meals)
    index = @meal_view.ask_for('number').to_i - 1
    meal = meals[index]

    # get the customers from the customer repository
    # tell the view to display the customers
    # ask the user for the number of the customer
    # get the customer using the index on the customers array
    customers = @customer_repository.all
    @customer_view.display(customers)
    index = @customer_view.ask_for('number').to_i - 1
    customer = customers[index]

    # get the riders from the employee repository
    # tell the view to display the riders
    # ask the user for the number of the rider
    # get the rider using the index on the riders array
    employees = @employee_repository.all_riders
    @employee_view.display(employees)
    index = @employee_view.ask_for('number').to_i - 1
    employee = employees[index]

    # create an instance of an order (meal, customer, rider)
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # give the order to the repository
    @order_repository.create(order)
  end
end
