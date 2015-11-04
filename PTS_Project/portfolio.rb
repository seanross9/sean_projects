require 'roo'

class StockHolding
	def initialize(index, shares, price)
		@index, @shares, @price = index, shares, price
	end

	attr_reader :index, :shares, :price
end

class Portfolio
	def initialize(initial_list, current_list)
		@initial_list, @current_list = initial_list, current_list
	end
	attr_reader :initial_list, :current_list

	def return_on_a_stock(initial_stock, current_stock)
		price_change = current_stock.price - initial_stock.price
		return_on_a_stock = price_change * current_stock.shares
	end

	def get_initial_stock_price(initial_stock)
		initial_price = initial_stock.price * initial_stock.shares
	end

	def get_current_stock_price(current_stock)
		current_price = current_stock.price * current_stock.shares
	end

	# def get_stock_value(list)
	# 	length = list.length
	# 	(0...length).each do |i|
	# 		value += list[i].shares * list[i].price
	# 	end
	# 	value
	# end

	def performance_report
		total_return = initial_investment = portfolio_value = 0
		length = @initial_list.length
		(0...length).each do |i|
			initial_investment += get_initial_stock_price(@initial_list[i])
			portfolio_value += get_current_stock_price(@current_list[i])
			total_return += return_on_a_stock(@initial_list[i], @current_list[i])
		end
		printf("Total Initial Investment:   $ %10.2f\n", initial_investment)
		printf("Current Portfolio Value:    $ %10.2f\n", portfolio_value)
		printf("Total ROI:                  $ %10.2f\n", total_return)
		printf("Average Annual ROI:         $ %10.2f\n", total_return/@initial_list.length)

		# get_stock_value(@initial_list)
		# get_stock_value(@current_list)
	end
end

# def open_file(filename)
# 	file = Roo::Spreadsheet.open(filename)
# end

puts 'Welcome to Your Portfolio Tracking System.'
puts 'Would you like to:'
puts '[p] View Securities Performance Report'
puts '[a] View Asset Allocation Report'
choice = gets.chomp

if choice == 'p'	
	# open_file('./stock_prices.xlsx')
	file = Roo::Spreadsheet.open('./stock_prices.xlsx')
	current_stock_list = []

	file.sheet('Oct 26 2015').each do |row|
		row.inspect
		 current_stock_list << StockHolding.new(*row)
	end

	initial_stock_list = []
	

	file.sheet('Jan 4 2010').each do |row|
		row.inspect
		 initial_stock_list << StockHolding.new(*row)
	end

	my_portfolio = Portfolio.new(initial_stock_list, current_stock_list)
	puts my_portfolio.performance_report


end







