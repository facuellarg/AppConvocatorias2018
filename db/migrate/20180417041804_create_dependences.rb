class CreateDependences < ActiveRecord::Migration[5.1]
  def change
    create_table :dependences do |t|
      t.string :name

    end
  end
end
