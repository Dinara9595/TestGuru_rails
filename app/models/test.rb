class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :questions, dependent: :destroy
  has_many :tests_users, dependent: :destroy
  has_many :users, through: :tests_users
  has_many :test_passages
  has_many :users, through: :test_passages

  validates :title, presence: { case_sensitive: true }, uniqueness: { scope: :level }
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

  def count_correct_answer_for_test(test)
    number = []
    test.questions.each do |question|
      number << question.answers.correct.size
    end
    number.size
  end

  def success_percent(test, test_passage)
    total_number = count_correct_answer_for_test(test)
    actual_number = test_passage.correct_questions
    ((actual_number.to_f / total_number.to_f ) * 100).to_i
  end


end
