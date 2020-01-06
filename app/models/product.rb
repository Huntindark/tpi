class Product < ApplicationRecord
has_many :items
  validates :unicode, format: { with: /[a-z]{3}\d{6}/ }

  def self.getScarce
    prods = Product.joins(:items).having('COUNT(*) > 0 AND COUNT(*) < 6').group(:id).count
    prods.map { |key, value|  { "#{Product.find(key).name}": value} }
  end

  def self.getInStock
    prods = Product.joins(:items).having('COUNT(*) > 0').group(:id).count 
    prods.map { |key, value|  { "#{Product.find(key).name}": value} }
  end

  def self.getAll
    prods = Product.joins(:items).group(:id).count
    prods.map { |key, value|  { "#{Product.find(key).name}": value} } 
   end

  def self.createItems(product, create)
    create.to_i.times {Item.create!(product_id: product, status: 'Disponible', created_at: Time.now.utc, updated_at: Time.now.utc)}
  end
end
