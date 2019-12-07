class AddSaleToReservation < ActiveRecord::Migration[6.0]
  def change
    add_reference :reservations, :sells
  end
end
