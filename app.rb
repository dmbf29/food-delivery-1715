# USER STORIES:
# [x] As a user, I can add a new meal
# [x] As a user, I can list all the meals
# [x] As a user, I can add a new customer
# [x] As a user, I can list all the customers

require_relative 'router'
require_relative './app/repositories/meal_repository'
require_relative './app/controllers/meals_controller'
require_relative './app/repositories/customer_repository'
require_relative './app/controllers/customers_controller'
require_relative './app/repositories/employee_repository'
require_relative './app/controllers/sessions_controller'

meals_repository = MealRepository.new('data/meals.csv')
meals_controller = MealsController.new(meals_repository)
customers_repository = CustomerRepository.new('data/customers.csv')
customers_controller = CustomersController.new(customers_repository)
employee_repository = EmployeeRepository.new('data/employees.csv')
sessions_controller = SessionsController.new(employee_repository)

router = Router.new(meals_controller, customers_controller, sessions_controller)
router.run
