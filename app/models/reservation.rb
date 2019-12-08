class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :sell
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
=begin
  def self.reserve(client, user, reserve)
  	response = {}
  	enough = reserve.all { |product| Product.hasStock(product)}
  	if enough
  		if Client.isClient(client)
  			if User.isUser(user)
  				Reservation.
  				Product.reserve(reserve) #change items status

  end
=end
end
