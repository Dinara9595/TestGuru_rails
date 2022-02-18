class Badge < ApplicationRecord
  enum file_name: [:badge_category, :badge_first_try, :badge_level]
  enum rule: [:by_category, :first_try, :by_level]
  enum rule_parameter: [:solar_system, :animals, :constellations, :light_level, :medium_level, :high_level, :not]

  belongs_to :author_badge, class_name: 'Admin', foreign_key: 'author_badge_id'

  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users

  validates :name, presence: true
  validates :file_name, presence: true
  validates :rule, presence: true
  validates :rule_parameter, presence: true

  def self.only_level_difficult
    by_level.pluck(:rule_parameter)
  end
end
