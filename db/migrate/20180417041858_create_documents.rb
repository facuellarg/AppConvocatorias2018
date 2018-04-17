class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :address
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
