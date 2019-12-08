class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :reserved

  def self.not_sold
    Reservation.joins(:client).where(status: 'Pendiente').select(:"reservations.created_at", :name, :total)
=begin    
    @connection = ActiveRecord::Base.connection
    result = @connection.exec_query("SELECT r.created_at, c.name, r.total
                                         FROM reservations as r INNER JOIN clients as c ON r.client_id = c.id
                                         WHERE status='Pendiente'")
    return result
=end
  end

  def self.findById(id)
	@connection = ActiveRecord::Base.connection
	result = @connection.exec_query("SELECT *
                                     FROM reservations
                                     WHERE id='#{id}'")
	return result[0]
  end

  #User should be the authentication token, dont forget to change it

  def self.reserve(params)
  	response = {}
  	enough = {}
    params[:to_reserve].each { |k, v| enough[k] = (Product.where(unicode: k).joins(:items).count) > v.to_i}
    if enough.all?
      client = Client.find(params[:client_id])
  		if client.present?
        user = User.find(params[:user_id])
  			if user.present?
          #total = params[:to_reserve].each { |k, v| Product.where(unicode: k).select(:basePrice) }
          total = {}
          params[:to_reserve].each { |k, v| total[k] = Product.where(unicode: k).select(:basePrice) } 
          total = total.values.flatten.collect { |p| p.basePrice }  
          total = total.inject(:+)
          time = Time.now.utc
  				reservation = Reservation.create!(client_id: client.id, user_id: user.id, created_at: time, updated_at: time, status: 'Pendiente', total: total)
          params[:to_reserve].each do |k, v| 
            v.to_i.times do
              product = Product.find_by(unicode: k)
              item = Item.find_by(product_id: product.id, status: 'Disponible')
              Reserved.create!(reservation_id: reservation.id, item_id: item.id, price: product.basePrice)
              item.update!(status: 'Reservado')
            end
          end
          reservation
        else 
          {status: 406, message: 'User doesnt exist'}
        end
      else
        {status: 406, message: 'Client doesnt exist'}  
      end
    else
      {status: 406, message: 'Not enough stock'}
    end
  end

  def self.sell(res)
    time = Time.now.utc
    sale = Sell.create!(client_id: res.client_id, user_id: res.user_id, created_at: time, updated_at: time, total: res.total, reservation_id: res.id)
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
