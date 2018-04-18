class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :lastname
      t.string :permits
      t.integer :phone_ext
      t.references :dependence, foreign_key: true

      t.timestamps
    end
  end
end
