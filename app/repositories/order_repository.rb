require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = [] # array of instances of order
    @last_id = 0

    load_csv if File.exist?(@csv_file_path)
  end

  def create(order)
    # Set an ID to the order instance that we are adding
    order.id = @last_id + 1
    # Add the order to the @orders array
    add_to_repo(order)
    # Saving CSV
    save_csv
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def find(id)
    @orders.find { |order| order.id == id.to_i }
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def add_to_repo(order)
    @orders << order
    @last_id = order.id
  end

  def load_csv
    # return unless File.exist?(@csv_file_path)
    CSV.foreach(@csv_file_path, headers: :first_row) do |row|
      # Optional: headers_converter: :symbol to convert keys to symbols
      # We take each row from the CSV and convert them to order instances
      order = Order.new(
        id: row['id'].to_i,
        meal: @meal_repository.find(row['meal_id'].to_i),
        customer: @customer_repository.find(row['customer_id'].to_i),
        employee: @employee_repository.find(row['employee_id'].to_i),
        delivered: row['delivered'] == 'true'
      )
      # We add the orders to the @orders array
      add_to_repo(order)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # Add the headers to the CSV
      csv << %w[id meal_id customer_id employee_id delivered]
      # Add each of the orders as a row to the CSV
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end
