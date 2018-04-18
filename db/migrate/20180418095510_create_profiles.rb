class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :description
      t.references :convocation, foreign_key: true

      
    end
  end
end
