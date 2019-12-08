class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :reserved

  def self.notSold
    @connection = ActiveRecord::Base.connection
    result = @connection.exec_query("SELECT *
                                         FROM reservations
                                         WHERE status='Pendiente'")
    return result

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
