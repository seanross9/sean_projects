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

	def get_stock_value(list)
		value = total_return = 0
		list.each do |stock|
			value += stock.shares * stock.price
		end
		value
	end

	def performance_report
		initial_investment = get_stock_value(@initial_list)
		portfolio_value = get_stock_value(@current_list)
		printf("Total Initial Investment:   $ %9.2f\n", initial_investment)
		printf("Current Portfolio Value:    $ %9.2f\n", portfolio_value)
		printf("Total ROI:                  $ %9.2f\n", total_return = portfolio_value - initial_investment)
		printf("Average Annual ROI:         $ %9.2f\n", total_return/@initial_list.length)
	end
end

def open_file(filename)
	@file = Roo::Spreadsheet.open(filename)
end

def read_sheet(sheetname)
	stock_list = []
	@file.sheet(sheetname).each do |row|
		row.inspect
		 stock_list << StockHolding.new(*row)
	end
	stock_list
end

puts 'Welcome to Your Portfolio Tracking System.'
puts 'Would you like to:'
puts '[p] View Securities Performance Report'
puts '[a] View Asset Allocation Report'
choice = gets.chomp

if choice == 'p'	
	open_file('./stock_prices.xlsx')
	current_stock_list = read_sheet('Oct 26 2015')
	initial_stock_list = read_sheet('Jan 4 2010')

	my_portfolio = Portfolio.new(initial_stock_list, current_stock_list)
	puts my_portfolio.performance_report
end







