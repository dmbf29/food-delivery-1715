class EmployeeView
  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end

  def ask_for(attribute)
    puts "What is the employee's #{attribute}?"
    print '> '
    gets.chomp
  end
end
