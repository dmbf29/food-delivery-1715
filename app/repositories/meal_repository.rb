require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = [] # array of instances of Meal
    @last_id = 0

    load_csv if File.exist?(@csv_file_path)
  end

  def create(meal)
    # Set an ID to the meal instance that we are adding
    meal.id = @last_id + 1
    # Add the meal to the @meals array
    add_to_repo(meal)
    # Saving CSV
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id.to_i }
  end

  private

  def add_to_repo(meal)
    @meals << meal
    @last_id = meal.id
  end

  def load_csv
    # return unless File.exist?(@csv_file_path)
    CSV.foreach(@csv_file_path, headers: :first_row) do |row|
      # Optional: headers_converter: :symbol to convert keys to symbols

      # p row # <CSV::Row id: '1', name: 'Burger', price: '2000'>
      # We take each row from the CSV and convert them to Meal instances
      meal = Meal.new(
        id: row['id'].to_i,
        name: row['name'],
        price: row['price'].to_i
      )
      # We add the meals to the @meals array
      add_to_repo(meal)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # Add the headers to the CSV
      csv << %w[id name price]
      # Add each of the meals as a row to the CSV
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end