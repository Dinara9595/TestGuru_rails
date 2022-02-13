class BadgeRule < ApplicationRecord
  validates :name, presence: true

  belongs_to :author_rule, class_name: 'Admin', foreign_key: 'author_rule_id'
  has_many :badge, dependent: :destroy, foreign_key: 'rule_id'


end
