class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :job, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
