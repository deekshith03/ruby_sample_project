class CreatePerson < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :admin
      t.string :slug
      t.boolean :validated
      t.string :handle
      t.integer :team
      t.timestamps
    end
  end
end
