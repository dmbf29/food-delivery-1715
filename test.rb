require_relative 'app/models/meal'
require_relative 'app/repositories/meal_repository'

meal_repository = MealRepository.new('data/meals.csv')

meal = Meal.new(name: 'Sushi', price: 25000)
meal_repository.create(meal)

meal = Meal.new(name: 'Pizza', price: 12000)
meal_repository.create(meal)

pp meal_repository