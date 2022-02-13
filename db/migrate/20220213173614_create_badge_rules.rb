class CreateBadgeRules < ActiveRecord::Migration[6.1]
  def change
    create_table :badge_rules do |t|
      t.string :name
      t.references :author_rule, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
