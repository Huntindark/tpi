class CreateSolds < ActiveRecord::Migration[6.0]
  def change
    create_table :solds do |t|
      t.references :sell, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
