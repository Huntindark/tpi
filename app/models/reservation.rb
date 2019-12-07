class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user

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

end
