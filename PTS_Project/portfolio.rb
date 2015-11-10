require 'roo'
require 'httparty'
require 'json'

class StockHolding
	def initialize(index, shares, price)
		@index, @shares, @price = index, shares, price
	end

	attr_reader :index, :shares, :price
end

class Portfolio
	def initialize(initial_list)
		@initial_list = initial_list
	end

	def get_stock_value(list)
		value = total_return = 0
		list.each do |stock|
			value += stock.shares * stock.price
		end
		value
	end

	def load_prices_from_excel(filename)
		@price_lookup = {}
		new_file = ExcelFile.new(filename)
		current_list = new_file.read_sheet('Oct 26 2015')
		current_list.each do |stock|
			@price_lookup[stock.index] = stock.price
		end
	end

	def get_current_portfolio_value
		value = 0
		@initial_list.each do |stock|
			value += stock.shares * @price_lookup[stock.index]
		end
		value
	end

	def performance_report
		initial_investment = get_stock_value(@initial_list)
		portfolio_value = get_current_portfolio_value
		printf("Total Initial Investment:   $ %9.2f\n", initial_investment)
		printf("Current Portfolio Value:    $ %9.2f\n", portfolio_value)
		printf("Total ROI:                  $ %9.2f\n", total_return = portfolio_value - initial_investment)
		printf("Average Annual ROI:         $ %9.2f\n", total_return/@initial_list.length)
	end

	def get_price_for_symbol(stock_ticker)
		#puts stock_ticker.inspect
		url = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol="+stock_ticker
		stock = HTTParty.get(url)
		my_hash = JSON.parse(stock.body)
		my_hash["LastPrice"]
	end

	def load_prices_from_api
		@price_lookup = {}
		@initial_list.each do |stock|
			@price_lookup[stock.index] = get_price_for_symbol(stock.index)
		end
	end
end

class ExcelFile
	def initialize(filename)
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
end

puts 'Welcome to Your Portfolio Tracking System.'
puts 'Would you like to:'
puts '[p] View Securities Performance Report'
puts '[a] View Asset Allocation Report'
choice = gets.chomp

if choice == 'p'	
	new_file = ExcelFile.new('./stock_prices.xlsx')
	initial_stock_list = new_file.read_sheet('Jan 4 2010')
	my_portfolio = Portfolio.new(initial_stock_list)
	#my_portfolio.load_prices_from_excel('./stock_prices.xlsx')
	my_portfolio.load_prices_from_api
	puts my_portfolio.performance_report
end








