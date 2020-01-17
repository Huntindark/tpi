class Item < ApplicationRecord
  belongs_to :product
=begin
  def self.createFor(prod)
  	    @connection = ActiveRecord::Base.connection
        code = prod['id']
        time = Time.now.getutc
        result = @connection.exec_query("INSERT INTO items (product_id, status, created_at, updated_at)
										 VALUES ('#{code}', 'Disponible', '#{time}', '#{time}')")
  end
=end
  def self.sold(item)
  	item.update!(status: 'Vendido')
  end

 	def self.reserve(item)
	  item.update!(status: 'Reservado')
  end
end
