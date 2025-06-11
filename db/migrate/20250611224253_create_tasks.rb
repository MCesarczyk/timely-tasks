class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end
end
