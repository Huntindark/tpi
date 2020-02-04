class Product < ApplicationRecord
has_many :items
  validates :unicode, format: { with: /[a-z]{3}\d{6}/, message: 'Se requiere que el formato sea de 3 letras y 6 numeros'}
  validates :desc, length: { maximum: 200 }, presence: true
  validates :detail, presence: true
  validates :basePrice, presence: true

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

  def self.productStock(unicode)
    Product.joins(:items).where(products: {unicode: unicode}, items: {status: 'Disponible'}).count
  end

  def self.enough(needed)
    enough = {}
    needed.each { |k, v| enough[k] = (Product.productStock(k) > v.to_i) }
    !enough.value?(false)
  end

  def self.total_for(needed)
  total = {}
    needed.each { |k, v| total[k] = Product.where(unicode: k).select(:basePrice) } 
    total = total.values.flatten.collect { |p| p.basePrice }  
    total = total.inject(:+)
    total
  end

end
