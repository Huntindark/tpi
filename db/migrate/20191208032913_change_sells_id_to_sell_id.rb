class ChangeSellsIdToSellId < ActiveRecord::Migration[6.0]
  def change
  	rename_column :reservations, :sells_id, :sell_id
  end
end
