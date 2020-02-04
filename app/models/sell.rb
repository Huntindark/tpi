class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user

  has_one :reserved

	def self.sell(sale, user)
		total = Product.total_for(sale[:to_sell])
		time = Time.now.utc
		selling = Sell.create!(client_id: sale[:client_id], user_id: user.id, created_at: time, updated_at: time, total: total)
    	sale[:to_sell].each do |k, v| 
		    product = Product.find_by(unicode: k)
		    items = Item.where(product_id: product.id, status: 'Disponible').first(v.to_i)
		    items.each do | item | 
		    	Sold.create!(sell_id: selling.id, item_id: item.id, price: product.basePrice)
		    	Item.sold(item)
	    end
    end
    selling
  end

end
