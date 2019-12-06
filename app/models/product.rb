class Product < ApplicationRecord
has_many :items
	def self.getScarce(prod)
        @connection = ActiveRecord::Base.connection
  		result = @connection.exec_query("SELECT count(items.product_id) 
                                         FROM products NATURAL JOIN items
                                         WHERE products.name='#{prod.name}'")
        return result
	end

end
