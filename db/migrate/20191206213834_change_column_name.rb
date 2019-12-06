class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
  	rename_column :products, :uniCode, :unicode
  end
end
