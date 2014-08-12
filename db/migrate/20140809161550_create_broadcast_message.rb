class CreateBroadcastMessage < ActiveRecord::Migration
  def change
    create_table :broadcast_messages do |t|
      t.text :message
      t.integer :alert_type

      t.timestamps
    end
  end
end
