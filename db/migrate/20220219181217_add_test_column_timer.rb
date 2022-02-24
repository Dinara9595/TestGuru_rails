class AddTestColumnTimer < ActiveRecord::Migration[6.1]
  def change
    change_table :tests do |t|
      add_column :tests, :timer, :integer, default: 15
    end
  end
end
