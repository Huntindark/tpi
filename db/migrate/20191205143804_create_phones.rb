class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.string :number, null: false
      t.references :client, null: false

      t.timestamps
    end
  end
end
