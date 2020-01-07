class AddExperetiesToCandidate < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :expreties, :string
  end
end
