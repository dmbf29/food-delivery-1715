require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = [] # array of instances of Customer
    @last_id = 0

    load_csv if File.exist?(@csv_file_path)
  end

  def create(customer)
    # Set an ID to the customer instance that we are adding
    customer.id = @last_id + 1
    # Add the customer to the @customers array
    add_to_repo(customer)
    # Saving CSV
    save_csv
  end

  def all
    @customers
  end

  def find(id)
    @customers.find { |customer| customer.id == id.to_i }
  end

  private

  def add_to_repo(customer)
    @customers << customer
    @last_id = customer.id
  end

  def load_csv
    # return unless File.exist?(@csv_file_path)
    CSV.foreach(@csv_file_path, headers: :first_row) do |row|
      # Optional: headers_converter: :symbol to convert keys to symbols

      # p row # <CSV::Row id: '1', name: 'Burger', address: '2000'>
      # We take each row from the CSV and convert them to Customer instances
      customer = Customer.new(
        id: row['id'].to_i,
        name: row['name'],
        address: row['address']
      )
      # We add the customers to the @customers array
      add_to_repo(customer)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # Add the headers to the CSV
      csv << %w[id name address]
      # Add each of the customers as a row to the CSV
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end