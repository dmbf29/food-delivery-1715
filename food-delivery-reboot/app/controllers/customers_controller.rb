require_relative '../views/customer_view'

class CustomersController
  # [ ] As a user, I can add a new customer
  # [ ] As a user, I can list all the customers
  def initialize(repository)
    @repository = repository
    @view = CustomerView.new
  end

  def list
    # Fetch all of the customers from the repository
    customers = @repository.all
    # Ask the view to display the customers
    @view.display(customers)
  end

  def add
    # Ask the user for a name
    name = @view.ask_for('name')
    # Ask the user for a address
    address = @view.ask_for('address')
    # Create the customer
    customer = Customer.new(name: name, address: address)
    # Store the customer in the repository
    @repository.create(customer)
  end
end