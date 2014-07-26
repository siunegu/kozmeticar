class AddReservationSlotToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :reservation_slots, :integer, default: 1
  end
end
