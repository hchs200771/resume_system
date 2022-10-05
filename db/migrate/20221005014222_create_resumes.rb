class CreateResumes < ActiveRecord::Migration[7.0]
  def change
    create_table :resumes do |t|
      t.string :name
      t.string :template
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
