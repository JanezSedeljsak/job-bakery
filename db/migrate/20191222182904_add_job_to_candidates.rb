class AddJobToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_reference :candidates, :job, foreign_key: true
  end
end
