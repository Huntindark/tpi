class Item < ApplicationRecord
  belongs_to :product

  def self.create_for(prod)
  	    @connection = ActiveRecord::Base.connection
        code = prod['id']
        time = Time.now.getutc
        result = @connection.exec_query("INSERT INTO items (product_id, status, created_at, updated_at)
										 VALUES ('#{code}', 'Disponible', '#{time}', '#{time}')")
  end
end
