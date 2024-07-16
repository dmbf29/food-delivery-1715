require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = [] # array of instances of employee

    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @employees
  end

  def find(id)
    @employees.find { |employee| employee.id == id.to_i }
  end

  def find_by_username(username)
    # return an instance of an employee OR nil
    @employees.find { |employee| employee.username == username }
  end

  private

  def add_to_repo(employee)
    @employees << employee
  end

  def load_csv
    # return unless File.exist?(@csv_file_path)
    CSV.foreach(@csv_file_path, headers: :first_row) do |row|
      # Optional: headers_converter: :symbol to convert keys to symbols

      # p row # <CSV::Row id: '1', name: 'Burger', price: '2000'>
      # We take each row from the CSV and convert them to employee instances
      employee = Employee.new(
        id: row['id'].to_i,
        username: row['username'],
        password: row['password'],
        role: row['role']
      )
      # We add the employees to the @employees array
      add_to_repo(employee)
    end
  end
end
