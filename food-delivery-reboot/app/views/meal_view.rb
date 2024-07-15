class MealView
  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1}. #{meal.name} (ID##{meal.id})\n¥#{meal.price}\n-----------"
    end
  end

  def ask_for(attribute)
    puts "What is the meal's #{attribute}?"
    print '> '
    gets.chomp
  end
end