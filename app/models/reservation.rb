class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :reserved

  def self.not_sold
    Reservation.joins(:client).where(status: 'Pendiente').select(:"reservations.created_at", :name, :total)
  end

  def self.reserve(res, user)
    if Product.enough(res[:to_reserve])
  		if Client.find(res[:client_id]).present?
        total = Product.total_for(res[:to_reserve])
        time = Time.now.utc
				reservation = Reservation.create!(client_id: res[:client_id], user_id: user.id, created_at: time, updated_at: time, status: 'Pendiente', total: total)
        res[:to_reserve].each do |k, v| 
          product = Product.find_by(unicode: k)
          items = Item.where(product_id: product.id, status: 'Disponible').first(v.to_i)
          items.each do |item|
            Reserved.create!(reservation_id: reservation.id, item_id: item.id, price: product.basePrice)
            Item.reserve(item)
          end
        end
        reservation
      else
        {status: 406, message: 'Client doesnt exist'}  
      end
    else
      {status: 406, message: 'Not enough stock'}
    end
  end

  def self.sell(res, user)
    time = Time.now.utc
    sale = Sell.create!(client_id: res.client_id, user_id: user.id, created_at: time, updated_at: time, total: res.total, reservation_id: res.id)
    res.update!(status: 'Vendido')
    reserved = Reserved.where(reservation_id: res.id)
    sold = reserved.map do |toSell| 
      item = Item.find(toSell.item_id)
      Reserved.joins(:item).joins("INNER JOIN products ON items.product_id = products.id") 
      prod = Product.find(item.product_id)
      Sold.create!(sell_id: sale.id, item_id: toSell.item_id, ) 
    end
  end

end
