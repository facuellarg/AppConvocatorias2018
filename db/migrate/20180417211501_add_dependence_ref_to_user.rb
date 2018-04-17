class AddDependenceRefToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :dependence, foreign_key: true
  end
end
