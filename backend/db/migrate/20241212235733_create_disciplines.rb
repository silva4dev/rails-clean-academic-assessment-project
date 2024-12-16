class CreateDisciplines < ActiveRecord::Migration[7.2]
  def change
    create_table :disciplines, id: :uuid do |t|
      t.string :name
      t.integer :days_interval, null: true

      t.timestamps
    end
  end
end
