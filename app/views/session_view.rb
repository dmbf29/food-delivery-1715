class SessionView
  def ask_for(attribute)
    puts "What is the employee's #{attribute}?"
    print '> '
    gets.chomp
  end

  def welcome(employee)
    puts "Welcome #{employee.username}!"
  end

  def wrong_credentials
    puts 'Sorry wrong username or password.'
  end
end
