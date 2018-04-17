class CreateConvocationDependences < ActiveRecord::Migration[5.1]
  def change
    create_table :convocation_dependences do |t|
      t.belongs_to :convocation, index: true
      t.belongs_to :dependence, index: true

      t.timestamps
    end
  end
end
