class Admin < User
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :created_badges, class_name: 'Badge', foreign_key: 'author_badge_id', dependent: :destroy
  has_many :created_rules, class_name: 'BadgeRule', foreign_key: 'author_rule_id', dependent: :destroy
end
