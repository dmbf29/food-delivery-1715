class CustomerView
  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1}. #{customer.name} (ID##{customer.id})\n#{customer.address}\n-----------"
    end
  end

  def ask_for(attribute)
    puts "What is the customer's #{attribute}?"
    print '> '
    gets.chomp
  end

  # def ask_for_index
  #   puts "Select a customer number"
  #   print '> '
  #   gets.chomp.to_i - 1
  # end
end