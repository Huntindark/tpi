class Product < ApplicationRecord
has_many :items

	def self.getProdStock(prod)
        @connection = ActiveRecord::Base.connection
  		result = @connection.exec_query("SELECT count(items.product_id) 
                                         FROM products INNER JOIN items ON products.id = items.product_id
                                         WHERE products.name='#{prod.name}'
                                            AND items.status='Disponible'")
        return result[0]['count']
	end

    #If there's time do something with duplicate code -- make only one function and send a block or something

    def self.getScarce(prods)
        query = {}
        prods.map { |prod| query[prod.name] = self.getProdStock(prod)}
        result = query.select { |p| ((query[p] > 0) && (6 > query[p]))}
        return result
    end

    def self.getInStock(prods)
        query = {}
        prods.map { |prod| query[prod.name] = self.getProdStock(prod)}
        result = query.select { |p| query[p] > 0}
        return result
    end

    def self.getAll(prods)
        query = {}
        prods.map { |prod| query[prod.name] = self.getProdStock(prod)}
        return query
    end

    def self.getProdByCode(code)
        @connection = ActiveRecord::Base.connection
        result = @connection.exec_query("SELECT * 
                                         FROM products 
                                         WHERE unicode='#{code}'")
        return result[0]
    end        

    def self.getProdItems(prod)
        @connection = ActiveRecord::Base.connection
        code = prod['unicode']
        result = @connection.exec_query("SELECT status
                                         FROM products INNER JOIN items ON products.id = items.product_id
                                         WHERE products.unicode='#{code}'")
        query = {}
        query[prod['name']] = result
        return query        
    end

    def self.createItems(prodcut, create)
        create.to_i.times {Item.createFor(product)}
end
