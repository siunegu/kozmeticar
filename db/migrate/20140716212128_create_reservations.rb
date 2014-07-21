class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :starts_at
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true
      t.boolean :is_canceled, default: false

      t.timestamps
    end
  end
end
