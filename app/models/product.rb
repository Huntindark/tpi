class Product < ApplicationRecord
has_many :items
  validates :unicode, format: { with: /[a-z]{3}\d{6}/ }

  def self.getScarce
    prods = Product.joins(:items).having('COUNT(*) > 0 AND COUNT(*) < 6').group(:id)
  end

  def self.getInStock
    prods = Product.joins(:items).having('COUNT(*) > 0').group(:id)
  end

  def self.getAll
    prods = Product.joins(:items).group(:id) 
   end

  def self.createItems(product, create)
    create.to_i.times {Item.create!(product_id: product, status: 'Disponible', created_at: Time.now.utc, updated_at: Time.now.utc)}
  end

  def self.enough(needed)
    enough = {}
    needed.each { |k, v| enough[k] = (Product.where(unicode: k).joins(:items).count) > v.to_i}
    enough?
  end

  def self.total_for(needed)
  total = {}
    needed.each { |k, v| total[k] = Product.where(unicode: k).select(:basePrice) } 
    total = total.values.flatten.collect { |p| p.basePrice }  
    total = total.inject(:+)
    total
  end

end
