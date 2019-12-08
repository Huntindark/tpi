class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user

  def self.saleFor(reservation)
    @connection = ActiveRecord::Base.connection
	result = @connection.exec_query("SELECT *
                                 FROM sells LEFT JOIN reservations ON reservations.sell_id = sells.id
                                 WHERE reservations.id = '#{reservation}'")
	return result[0]
  end
end
