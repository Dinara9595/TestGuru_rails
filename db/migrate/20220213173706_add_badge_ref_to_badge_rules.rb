class AddBadgeRefToBadgeRules < ActiveRecord::Migration[6.1]
  def change
    add_reference :badges, :rule, foreign_key: { to_table: :badge_rules }
  end
end
