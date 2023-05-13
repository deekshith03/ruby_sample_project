class AddDefaultValueForAdminInPerson < ActiveRecord::Migration[7.0]
  def change
    change_column :people, :admin, :bool, default: false
  end
end
