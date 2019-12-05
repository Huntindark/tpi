class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :ci
      t.string :name
      t.references :ivatype, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
