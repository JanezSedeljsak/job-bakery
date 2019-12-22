class AddAreaToJobs < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :area, foreign_key: true
  end
end
