class CreateApplicants < ActiveRecord::Migration[5.1]
  def change
    create_table :applicants do |t|
      t.references :users, foreign_key: true
      t.references :jobs, foreign_key: true

      t.timestamps
    end
  end
end
