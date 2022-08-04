require "byebug"
require_relative "cm.rb"

class AdminPanel

	def admin_panel
    puts "\n\t\t\t\t ************************************** "
  	puts "\t\t\t\t\t || ADMIN PANEL || ".blue.on_light_white.bold
    puts "\t\t\t\t ************************************** "

    puts "\nAdmin Options:-"
    puts " 1. SignUp \n 2. Login \n 3. Back \n 4. Exit "

    print 'Select option: '
    admin_choice = gets.chomp.to_i
    case admin_choice
    when 1
      SignLogin.new.signup
    when 2
      SignLogin.new.login
      admin_options
    when 3
      load 'login.rb'
    when 4
      PanelExit.new.panel_exits
    else
      puts 'Invalid Input. Try again!'
      admin_panel
    end
  end

  def admin_options
    puts "\n-------------------------------------"
    puts "\t Admin Options ".light_yellow.bold
    puts "-------------------------------------\n"

    puts "\n 1. Add Items \n 2. List of Products \n 3. Remove Items \n 4. Update details \n 5. Total Selling \n 6. Logout \n 7. Back \n 8. Exit " 
    print 'Select option: '
    admin_opt = gets.chomp.to_i
    case admin_opt
    when 1
      add_items
    when 2
      product_list
      admin_options
    when 3
      remove_items
    when 4
      update_details
    when 5
      puts 'Total Selling Amount!!!'.light_green.bold
      puts $total
      admin_options
    when 6
      LogoutExit.new.logout
    when 7
      admin_panel
    when 8
      LogoutExit.new.exits
    else
      puts "Invalid Input. Please Try again!\n"
      admin_options
    end
  end

  # $products = []

  $products = [{p_id: 1, p_name: 'soap', p_price: 25, p_qty: 100},
        {p_id: 2, p_name: 'rice', p_price: 35, p_qty: 50},
        {p_id: 3, p_name: 'shampoo', p_price: 10, p_qty: 60},
        {p_id: 4, p_name: 'milk', p_price: 60, p_qty: 25},
        {p_id: 5, p_name: 'butter', p_price: 50, p_qty: 10}]
  $p_id = 5
  def add_items
    $p_id += 1
    puts "\n||  ADD ITEMS  ||"
    puts '-----------------'
    print "\nEnter Product Name: "
    @p_name = gets.chomp
    print 'Enter Product Price: '
    @p_price = gets.chomp.to_i
    print 'Enter Product Quantity: '
    @p_qty = gets.chomp.to_i
    $products.push({
        p_id: $p_id,
        p_name: @p_name,
        p_price: @p_price,
        p_qty: @p_qty
        })
    if @p_name != '' && @p_price != '' && @p_qty != ''
      puts "\n=> Product added successfully. To see the product details see check stock...\n"
      admin_options
    else
      puts "Product details should not be empty. Try again!\n"
      add_items
    end
  end

  def product_list
    if $p_id != 0 
      puts "\n|| LIST OF PRODUCTS ||"
      puts '----------------------'

      puts "\n P_id\t\tP_Name\t\tP_Price\t\tP_Qty \n"
      $products.each do |key|
        print " #{key[:p_id]}\t\t"
        print "#{key[:p_name]}\t\t"
        print "#{key[:p_price]}\t\t"
        print "#{key[:p_qty]}"
        puts "\n"
      end
    else
      puts 'Sorry, No products available!! Please add firstly..'
      admin_options
    end
  end

  def remove_items
    if $p_id != 0
      puts "\n||  REMOVE ITEMS  ||"
      puts '--------------------'
      print "\nEnter product id: "
      remove_p_id = gets.chomp.to_i
      $products.each do |k|
        if remove_p_id == k[:p_id]
          $products.delete_if { |key| key[:p_id] == remove_p_id}
          admin_options
        end   
      end

      if $products.any? {|prod| remove_p_id != prod[:p_id]}
        puts 'Sorry, Product not found!!! Please Try Again...'
        admin_options
      end

    else
      puts 'Sorry, No products available in the list!! Please add firstly...'
      admin_options 
    end
  end

  def update_details
    if $p_id != 0
      puts "\n||  UPDATE DETAILS  ||"
      puts '----------------------'
      puts "\n 1. Update Product Name \n 2. Update Product Price \n 3. Update Product Quantity \n 4. Back "
      print "\nSelect option: "
      updt_opt = gets.chomp.to_i
      
      case updt_opt
      when 1
        print "\nEnter product id: "
        prod_id = gets.chomp.to_i
        print 'Enter existing product name: '
        prod_name = gets.chomp
        print 'Enter updated product name: '
        updt_name = gets.chomp

        $products.each do |prod|
          if prod_name == prod[:p_name] && prod_id == prod[:p_id]
            prod[:p_name] = updt_name.white.on_light_yellow.bold
            puts "Updates successfully!\n"
            update_details
          end
        end

        if $products.any? {|prod| prod_id != prod[:p_id]}
          puts 'Sorry, Product not found!!! Please Try Again...'
          update_details
        end

      when 2
        print 'Enter product id: '
        prod_id = gets.chomp.to_i
        print 'Enter updated product price : '
        updt_price = gets.chomp

        $products.each do |prod|
          if prod_id == prod[:p_id]
            prod[:p_price] = updt_price
            puts "Updates successfully!\n"
            update_details
          end
        end

        if $products.any? {|prod| prod_id != prod[:p_id]}
          puts 'Sorry, Product not found!!! Please Try Again...'
          update_details
        end

      when 3
        print 'Enter product id: '
        prod_id = gets.chomp.to_i
        print 'Enter upadated product quantity : '
        updt_qty = gets.chomp

        $products.each do |prod|
          if prod_id == prod[:p_id]
            prod[:p_qty] = updt_qty
            puts "Updates successfully!\n"
            update_details
          end
        end

        if $products.any? {|prod| prod_id != prod[:p_id]}
          puts 'Sorry, Product not found!!! Please Try Again...'
          update_details
        end

      when 4
        admin_options

      else
        puts 'Invalid Input. Please Try again!'
        update_details
      end

    else
      puts 'Sorry, No products available in the list!! Please add firstly...'
      admin_options 
    end
  end
end
