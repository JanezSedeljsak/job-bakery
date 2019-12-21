class AddAreaIdToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :area_id, :integer
  end
end
