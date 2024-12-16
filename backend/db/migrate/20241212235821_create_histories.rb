class CreateHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :histories, id: :uuid do |t|
      t.references :student, type: :uuid, null: false, foreign_key: true
      t.date :reference_date
      t.decimal :final_grade

      t.timestamps
    end
  end
end
