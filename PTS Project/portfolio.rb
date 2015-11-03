require 'roo'

class StockHolding
	def initialize(index, shares, price)
		@index = index
		@shares = shares
		@price = price
	end

	def get_index
		@index
	end

	def get_shares
		@shares
	end

	def get_price
		@price
	end

end

class Portfolio
	def initialize(initial_list, current_list)
		@initial_list = initial_list
		@current_list = current_list
	end

	def total_return
		total_return = 0
		length = @initial_list.length
		(0...length).each do |i|
			total_return += stock_return(@initial_list[i], @current_list[i])
		end
		total_return
	end

	def stock_return(initial_stock, current_stock)
		price_change = current_stock.get_price - initial_stock.get_price
		stock_return = price_change * current_stock.get_shares
	end
end

puts 'Welcome to Your Portfolio Tracking System.'
puts 'Would you like to:'
puts '[p] View Securities Performance Report'
puts '[a] View Asset Allocation Report'
choice = gets.chomp

if choice == 'p'
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
	puts my_portfolio.total_return


end







