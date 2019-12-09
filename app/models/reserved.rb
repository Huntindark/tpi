class Reserved < ApplicationRecord
  belongs_to :reservation
  belongs_to :item
=begin
  def self.itemsFor(reservation)
    @connection = ActiveRecord::Base.connection
	result = @connection.exec_query("SELECT *
                                 FROM reservations INNER JOIN reserveds ON reservations.id = reserveds.reservations_id
                                 WHERE reservations.id = '#{reservation}'")
	return result
  end
=end  
end
