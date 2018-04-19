class CreateUserDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :user_documents do |t|
      t.references :user, foreign_key: true
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
