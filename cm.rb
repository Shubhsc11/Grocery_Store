require "io/console"
require "byebug"

class SignLogin

	$u_id = 0
	$user1 = {}
	$user2 = []
	$user3 = []
	$c_id = 0
	$s_id = 0
	
	def signup
		$u_id += 1
		puts "\n-----------------------"
	  puts "\t Sign-Up ".red.on_light_yellow.bold 
	  puts "-----------------------\n"
	  print "Email id : "
	  user_id = gets.chomp
	  # puts '* NOTE:- Password can be 6-8 characters & in this range only- [A..Z,a..z,1..9,sp.char.(@$#%..etc.)]'.light_green
	  print "Password : " 
	  pswd = gets.chomp.to_i
	  # pswd = STDIN.noecho(&:gets).chomp
	  # regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	  # pswd_regex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,10}$/ #pswd should be 4 to 10 chars.
    if user_id == 'abc' && pswd == 123
	  	if $user_role == 'admin'
	  		$user1[:u_id] = 0
	  		$user1[:sk_id] = 1
	      $user1[:user_id] = user_id
	      $user1[:pswd]	= pswd
	    	puts "\nSign Up Successfully. Now login to continue...\n\n"
	    	AdminPanel.new.admin_panel
	    
	    elsif $user_role == 'customer'
	    	$c_id += 1
	    	$user2 << ({
	      	u_id: $u_id,
	      	c_id: $c_id,
	        user_id: user_id,
	        pswd: pswd
	        })
	    	puts "\nSign Up Successfully. Now login to continue...\n\n"
	    	CustomerPanel.new.buyer_panel

	    elsif $user_role == 'salesman'
	    	$s_id += 1
	    	$user3 << ({
	      	u_id: $u_id,
	      	s_id: $s_id,
	        user_id: user_id,
	        pswd: pswd
	        })
	    	puts "\nSign Up Successfully. Now login to continue...\n\n"
	    	SalesmanPanel.new.saler_panel
	    end
	    # byebug
	    # puts "\nSign Up Successfully. Now login to continue...\n\n"
	    # Login.new.select_choice

    else
      puts "\nYou entered something wrong. Try again!"
      signup
    end
  end


	def login
    if $u_id != 0
      puts "\n----------------------"
      puts "\t Login ".red.on_light_yellow.bold  
      puts "----------------------\n"
      print 'Email id: '
      user_id2 = gets.chomp
      print 'Password: '
      # pswd2 = STDIN.noecho(&:gets).chomp
	  	pswd2 = gets.chomp.to_i
      
    	if $user_role == 'admin'
    		if $sk_id != 0
	    		if user_id2 == $user1[:user_id] && pswd2 == $user1[:pswd]
	    			puts "\nLogin Successfully! Welcome #{user_id2}"
	        else
	      		puts "\n=> Sorry, Match not found!!! Please Try again...\n=> #{'NOTE'.light_red.bold}:- Please enter correct credentials! OR Sign Up with new credentials!"
	      		AdminPanel.new.admin_panel
	      	end
	      else
	      	puts "\nNo shopkeeper sign-up yet! Sign up firstly before login..."
	      end

    	elsif $user_role == 'customer'
    		if $c_id != 0
	    		$user2.each do |user2|
	    			if user_id2 == user2[:user_id] && pswd2 == user2[:pswd]
	    				puts "\nLogin Successfully! Welcome #{user_id2}"
	    			end
	    		end

	      	if $user2.any? {|user2| user_id2 != user2[:user_id] && pswd2 != user2[:pswd]}
	      		puts "Sorry, Incorrect Credentials! Try again...\n"
	      		login
	      	end
	      else
	      	puts "\nNo customer sign-up yet! Sign up firstly before login..."
	      	signup
	      end

    	elsif $user_role == 'salesman'
    		if $s_id != 0
		  		$user3.each do |user3|
		  			if user_id2 == user3[:user_id] && pswd2 == user3[:pswd]
		  				puts "\nLogin Successfully! Welcome #{user_id2}"
		  			end
		  		end

		  		if $user3.any? {|user3| user_id2 != user3[:user_id] && pswd2 != user3[:pswd]}
		    		puts "Sorry, Incorrect Credentials! Try again...\n"
		    		login
		    	end
		    else
		    	puts "\nNo salesman signup yet! Sign up firstly before login..."
	      	signup
	      end
    	end
        
    else
      puts "No users sign-up yet! Please sign up firstly...\n\n"
      # Login.new.select_choice
      signup
    end
  end
end

  # list of users
	# def users_exist
 #    if $u_id != 0 
 #      puts "LIST OF EXIST USERS:-\n"
 #      puts " User_id\t\t\tPassword \n"
 #      $users.each do |key|
 #        print " #{key[:user_id]}\t\t\t"
 #        print "#{key[:pswd]} "
 #        puts "\n"
 #      end
 #      # Login.new.select_choice
 #      login
 #    else
 #      puts "No users sign-up yet! Please sign up firstly...\n\n"
 #      signup
 #    end
 #  end
# end


class LogoutExit

	def logout
		print "\n=> Do you want to logout, sure?(y/n): "
    logout_option = gets.chomp
    if logout_option.downcase == 'y'
      puts 'Logout Successfully!!!'
      puts '****Thank You, Please visit again****'
      load 'login.rb'

    elsif logout_option.downcase == 'n'
    	puts "Okay!!! Continue ...\n"
	  	case $user_role
    	when $user_role == 'admin'
      	AdminPanel.new.admin_options

      when $user_role == 'customer'
    		CustomerPanel.new.customer_options

    	when $user_role == 'salesman'
    		SalesmanPanel.new.saler_options
    	end

    else
      puts "Invalid Input. Please press 'Y|y' or 'N|n' !\n"
      logout
    end
	end


	def exits
		print "\n=> Do you want to exit, sure?(y/n): "
    exit_option = gets.chomp
    if exit_option.downcase == 'y'
      puts '****Thank You, Please Visit Again!!!****'
      exit

    elsif exit_option.downcase == 'n'
    	puts "Okay!!! Continue ...\n"
      case $user_role
    	when $user_role == 'admin'
      	AdminPanel.new.admin_options

      when $user_role == 'customer'
    		CustomerPanel.new.customer_options

    	when $user_role == 'salesman'
    		SalesmanPanel.new.saler_options
    	end

    else
      puts "Invalid Input. Please press 'Y|y' or 'N|n' !\n"
      exits
    end
	end
end



class PanelExit
	def panel_exits
		print "\n=> Do you want to exit, sure?(y/n): "
    exit_option = gets.chomp.to_s
    if exit_option.downcase == 'y'
      puts '****Thank You, Please visit again****'
      exit 

    elsif exit_option.downcase == 'n'
	  	puts "Okay!!! Continue ...\n"
	  	case $user_role
	    when $user_role = 'admin'
	    	Admin_Panel.new.admin_panel

	    when $user_role = 'customer'
	  		Customer_Panel.new.buyer_panel

	  	when $user_role = 'salesman'
	  		Salesman_Panel.new.saler_panel

	  	when $user_role = ''
	  		load 'login.rb'
	  	end

    else
      puts "Invalid Input. Please press 'Y|y' or 'N|n' !\n"
    	panel_exits
    end
	end
end

