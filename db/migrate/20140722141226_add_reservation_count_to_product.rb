class AddReservationCountToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :reservations_count, :integer, default: 0
  end
end
