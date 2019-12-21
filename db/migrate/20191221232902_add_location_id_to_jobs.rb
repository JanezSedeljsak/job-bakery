class AddLocationIdToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :location_id, :integer
  end
end
