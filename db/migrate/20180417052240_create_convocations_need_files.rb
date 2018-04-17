class CreateConvocationsNeedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :convocations_need_files do |t|
      t.references :convocation, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
