require_relative '../views/meal_view'

class MealsController
  # [ ] As a user, I can add a new meal
  # [ ] As a user, I can list all the meals
  def initialize(repository)
    @repository = repository
    @view = MealView.new
  end

  def list
    # Fetch all of the meals from the repository
    meals = @repository.all
    # Ask the view to display the meals
    @view.display(meals)
  end

  def add
    # Ask the user for a name
    name = @view.ask_for('name')
    # Ask the user for a price
    price = @view.ask_for('price').to_i
    # Create the meal
    meal = Meal.new(name: name, price: price)
    # Store the meal in the repository
    @repository.create(meal)
  end
end