class Product < ApplicationRecord
has_many :items
=begin
  def self.getProdStock(prod)
    @connection = ActiveRecord::Base.connection
	  result = @connection.exec_query("SELECT count(items.product_id) 
                                     FROM products INNER JOIN items ON products.id = items.product_id
                                     WHERE products.name='#{prod.name}'
                                        AND items.status='Disponible'")
    return result[0]['count']
  end
=end
  #If there's time do something with duplicate code -- make only one function and send a block or something

  def self.getScarce
    prods = Product.joins(:items).group(:id).count.select { |k, v| (v > 0) && (v<6) } 
    prods.map { |key, value|  { "#{Product.find(key).name}": value} }
  end

  def self.getInStock
    prods = Product.joins(:items).group(:id).count.select { |k, v| (v > 0)} 
    prods.map { |key, value|  { "#{Product.find(key).name}": value} }
  end

  def self.getAll
    prods = Product.joins(:items).group(:id).count
    prods.map { |key, value|  { "#{Product.find(key).name}": value} } 
   end

=begin  def self.getProdByCode(code)
    @connection = ActiveRecord::Base.connection
    result = @connection.exec_query("SELECT * 
                                     FROM products 
                                     WHERE unicode='#{code}'")
    return result[0]
  end        
=end

=begin
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
=end
  def self.createItems(product, create)
    create.to_i.times {Item.create!(product_id: product, status: 'Disponible', created_at: Time.now.utc, updated_at: Time.now.utc)}
  end
end
