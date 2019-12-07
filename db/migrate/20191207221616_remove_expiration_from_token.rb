class RemoveExpirationFromToken < ActiveRecord::Migration[6.0]
  def change
  	remove_column :tokens, :expiration
  end
end
