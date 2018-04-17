class CreateApplicationDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :application_documents do |t|
      t.references :application, foreign_key: true
      t.references :user_document, foreign_key: true

      t.timestamps
    end
  end
end
