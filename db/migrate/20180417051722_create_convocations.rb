class CreateConvocations < ActiveRecord::Migration[5.1]
  def change
    create_table :convocations do |t|
      t.string :name
      t.string :description
      t.string :type_student
      t.date :end_date
      t.references :admin, foreign_key: true
      t.integer :vacants
      t.integer :hours_per_week
      t.float :payout
      t.integer :duration

      t.timestamps
    end
  end
end
