class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :uniCode
      t.string :desc
      t.string :detail
      t.decimal :basePrice, precision: 7, scale: 2

      t.timestamps
    end
  end
end
