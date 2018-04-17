class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.references :student, foreign_key: true
      t.references :convocation, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
