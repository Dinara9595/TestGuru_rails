class Badge < ApplicationRecord
  belongs_to :author_badge, class_name: 'Admin', foreign_key: 'author_badge_id'
  belongs_to :badge_rule, class_name: 'BadgeRule', foreign_key: 'rule_id'

  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users

  validates :name, presence: true, uniqueness: true
  validates :file_name, presence: true
end
