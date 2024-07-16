require_relative '../views/session_view'

class SessionsController

  def initialize(employee_repository)
    @employee_repository = employee_repository
    @session_view = SessionView.new
  end

  # User Actions
  def log_in
    # tell the view to ask for username
    username = @session_view.ask_for('username')
    # tell the view to ask for password
    password = @session_view.ask_for('password')
    # ask the repository for an employee with that username
    employee = @employee_repository.find_by_username(username)
    # check if that employee's password matches the one given
    # if employee&.password == password
    if employee && employee.password == password
      #   start a session / welcome user
      @session_view.welcome(employee)
      return employee # the current_user
    else
      #   tell user wrong credentials and try again
      @session_view.wrong_credentials
      log_in
    end
  end
end
