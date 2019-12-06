class Product < ApplicationRecord
has_many :items
	def self.getScarce(prod)
=begin
        @connection = ActiveRecord::Base.connection
  		result = @connection.exec_query("SELECT count(items) 
                                         FROM products inner join items on products.uniCode=item.product_id 
                                         WHERE products.detail='#{prod.detail}'")
=end
        return prod.detail
	end

end
