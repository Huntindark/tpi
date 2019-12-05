class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :uniCode, unique: true, null: false
      t.string :desc, limit: 20000, null: false
      t.string :detail, null: false
      t.decimal :basePrice, precision: 7, scale: 2, null: false

      t.timestamps
    end
  end
end
