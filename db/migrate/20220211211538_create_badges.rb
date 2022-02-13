class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :file_name
      t.references :author_badge, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
