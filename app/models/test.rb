class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :questions, dependent: :destroy
  has_many :tests_users, dependent: :destroy
  has_many :users, through: :tests_users

  validates :title, presence: { case_sensitive: true }, uniqueness: true
  validates :level, numericality: { :greater_than_or_equal_to => 0, only_integer: true }

  scope :light_level, -> { where(level: 0..1) }
  scope :medium_level, -> { where(level: 2..4) }
  scope :high_level, -> { where(level: 5..Float::INFINITY) }
  scope :title_tests, ->(name_category) {
                        joins(:category).where(categories: { name: name_category }).order(title: :desc)
                      }
  scope :level, ->(level) { where(level: level) } # для того чтобы узнать список всех тестов, который
  # проходит пользователь на данном уровне сложности (например, 1) надо вызывать вот так user1.tests.level(1)

  def self.only_title_tests(name_category)
    self.title_tests(name_category).pluck(:title)
  end
end
