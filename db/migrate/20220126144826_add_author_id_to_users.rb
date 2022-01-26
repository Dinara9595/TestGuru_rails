class AddAuthorIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :author_id, :integer
  end
end
