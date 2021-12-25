class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :questions, dependent: :destroy
  has_many :tests_users, dependent: :destroy
  has_many :users, through: :tests_users

  scope :light_level, -> (level) {where(level: level) if (0..1).include?(level)}
  scope :medium_level, -> (level) {where(level: level) if (2..4).include?(level)}
  scope :high_level, -> (level) {where(level: level) if (5..Float::INFINITY).include?(level)}
  scope :title_tests, -> (name_category) {joins(:category).where(categories: {name: name_category}).order(title: :desc).pluck(:title)}
  scope :level, -> (level) {where(level: level)} #для того чтобы узнать список всех тестов, который
  # проходит пользователь на данном уровне сложности (например, 1) надо вызывать вот так user1.tests.level(1)

  validates :title, presence: { case_sensitive: true}, uniqueness: true
  validates :level, numericality: {:greater_than_or_equal_to => 0, only_integer: true}, uniqueness: true

end
