class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :product, null: false, foreign_key: true, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
