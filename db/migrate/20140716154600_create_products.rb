class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.datetime :available_at
      t.boolean :is_promoted, default: false
      t.belongs_to :user, index: true
      t.text :description

      t.timestamps
    end
  end
end
