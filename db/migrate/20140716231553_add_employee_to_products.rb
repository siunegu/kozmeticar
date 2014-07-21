class AddEmployeeToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :employee, :string
  end
end
