class CreateRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements do |t|
      t.references :convocation, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
