require 'roo'

class Stock_holding
	def initialize(index, shares, price)
		puts "Index: #{index}, #{shares} shares @ $#{price}"
	end
end

class Portfolio
	def initialize(list_of_stocks)
	end
end

def annual_return(current_value, initial_value)
	puts price_change = current_value - initial_value
end

puts 'Welcome to Your Portfolio Tracking System.'
puts 'Would you like to:'
puts '[p] View Securities Performance Report'
puts '[a] View Asset Allocation Report'
choice = gets.chomp

if choice == 'p'
	puts 'Your Current Holdings: '
	file = Roo::Spreadsheet.open('./stock_prices.xlsx')
	stocks = []

	file.each do |row|
		row.inspect
		stocks << Stock_holding.new(*row)
		#fake_current_value = Stock_holding(2)
	end
	
	fake_initial_value = 100
	fake_current_value = 150
	annual_return(fake_current_value, fake_initial_value)
end







