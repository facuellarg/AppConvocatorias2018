class CreateRequiredFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :required_files do |t|
      t.string :name

    end
  end
end
