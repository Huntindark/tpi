class AddExpirationToToken < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :expiration, :integer
  end
end
