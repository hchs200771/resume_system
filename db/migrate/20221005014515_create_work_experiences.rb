class CreateWorkExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :work_experiences do |t|
      t.references :candidate, null: false, foreign_key: true
      t.string :company
      t.integer :years

      t.timestamps
    end
  end
end
