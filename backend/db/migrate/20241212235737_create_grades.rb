class CreateGrades < ActiveRecord::Migration[7.2]
  def change
    create_table :grades, id: :uuid do |t|
      t.references :student, type: :uuid, null: false, foreign_key: true
      t.references :discipline, type: :uuid, null: false, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end
