class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.integer :file_name, null: false
      t.integer :rule, null: false
      t.integer :rule_parameter, null: false

      t.references :author_badge, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
