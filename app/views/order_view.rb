class OrderView
  def display(orders)
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1}. #{order.meal.name} (Customer: #{order.customer.name} => #{order.customer.address})\nRider: #{order.employee.username}\n-----------"
      end
    else
      puts "No orders yet 🍽️"
    end
  end

  def ask_for(attribute)
    puts "What is the order's #{attribute}?"
    print '> '
    gets.chomp
  end
end
