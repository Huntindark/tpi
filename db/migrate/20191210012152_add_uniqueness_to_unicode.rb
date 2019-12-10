class AddUniquenessToUnicode < ActiveRecord::Migration[6.0]
  def change
  	add_index :products, :unicode, unique: true
  end
end
