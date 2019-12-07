class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.references :user, null: true, foreign_key: true
      t.string :authentication

      t.timestamps
    end
  end
end
