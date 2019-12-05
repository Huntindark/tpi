class CreateIvatypes < ActiveRecord::Migration[6.0]
  def change
    create_table :ivatypes do |t|
      t.string :description

      t.timestamps
    end
  end
end
