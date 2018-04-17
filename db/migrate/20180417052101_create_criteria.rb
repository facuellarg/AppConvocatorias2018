class CreateCriteria < ActiveRecord::Migration[5.1]
  def change
    create_table :criteria do |t|
      t.references :convocation, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
