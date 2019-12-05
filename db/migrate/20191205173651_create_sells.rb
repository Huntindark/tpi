class CreateSells < ActiveRecord::Migration[6.0]
  def change
    create_table :sells do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :reservation, null: true, foreign_key: true

      t.timestamps
    end
  end
end
