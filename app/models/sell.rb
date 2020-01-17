class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user

	def self.sell(sale, user)
		if Product.enough(sale[:to_sell])
      if (Client.find(sale[:client_id])).present?
				total = Product.total_for(sale[:to_sell])
				time = Time.now.utc
				selling = Sell.create!(client_id: sale[:client_id], user_id: user.id, created_at: time, updated_at: time, total: total)
	      sale[:to_sell].each do |k, v| 
			    product = Product.find_by(unicode: k)
			    items = Item.where(product_id: product.id, status: 'Disponible').first(v)
			    items.each do | item | 
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
