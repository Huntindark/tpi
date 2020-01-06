class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user
=begin
  def self.saleFor(reservation)
    @connection = ActiveRecord::Base.connection
	result = @connection.exec_query("SELECT *
                                 FROM sells LEFT JOIN reservations ON reservations.sell_id = sells.id
                                 WHERE reservations.id = '#{reservation}'")
	return result[0]
  end

=end

	def self.enough(to_sell)
		enough = {}
	    to_sell.each { |k, v| enough[k] = (Product.where(unicode: k).joins(:items).count) > v.to_i}
	    enought.all? 
	end

	def self.total_for(to_sell)
		total = {}
        to_sell.each { |k, v| total[k] = Product.where(unicode: k).select(:basePrice) } 
        total = total.values.flatten.collect { |p| p.basePrice }  
        total = total.inject(:+)
        total
    end

	def self.sell(sale, user)
		if self.enough(sale[:to_sell])
      		if (Client.find(sale[:client_id])).present?
				total = self.total_for(sale[:to_sell])
				time = Time.now.utc
				selling = Sell.create!(client_id: sale[:client_id], user_id: user.id, created_at: time, updated_at: time, total: total)
		        sale[:to_sell].each do |k, v| 
		          v.to_i.times do
		            product = Product.find_by(unicode: k)
		            item = Item.find_by(product_id: product.id, status: 'Disponible')
		            Sold.create!(sell_id: selling.id, item_id: item.id, price: product.basePrice)
		            Item.sold(item)
		          end
		        end
		        selling
	    	else
        		{status: 406, message: 'Client doesnt exist'}  
      		end
    	else
      		{status: 406, message: 'Not enough stock'}
    	end
  end

end
