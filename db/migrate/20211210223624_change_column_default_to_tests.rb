class ChangeColumnDefaultToTests < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tests, :level, from: true, to: 0
  end
end
