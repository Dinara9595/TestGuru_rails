class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :confirmable

  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages, source: :test
  has_many :gists, dependent: :destroy
  has_many :badges_users, dependent: :destroy
  has_many :badges, through: :badges_users, source: :badge

  validates :email, presence: true, length: { maximum: 255 },
            uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }


  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def badge_by_category(category)
    number_of_tests_by_category = Test.only_title_tests(category)
    array_tests = []
    test_passages.each do |test_passage|
      array_tests << test_passage.test.title if test_passage.successful? && test_passage.test.category.name == category
    end
    if array_tests.size == number_of_tests_by_category.size
      add_badge(1)
    end
  end

  def badge_by_test_first_try(test_title)
    array_tests = []
    test_passages.each do |test_passage|
      array_tests << test_passage if test_passage.test.title == test_title
    end

    add_badge(2) if array_tests.size == 1 && array_tests[0].successful?
  end

  def badge_by_test_level(level)
    number_of_tests_by_level = level_difficulty(level)
    array_tests = []
    number_of_tests_by_level.each do |test|
      test_passages.each do |test_passage|
        array_tests << test if test == test_passage.test && test_passage.successful?
      end
    end
    add_badge(3) if array_tests.size == number_of_tests_by_level.size
  end

  def level_difficulty(level)
    case level
    when 0..1
      Test.light_level
    when 2..4
      Test.medium_level
    when 5..Float::INFINITY
      Test.high_level
    end
  end

  def add_badge(number)
    badge = Badge.find(number)
    badges.push(badge)
  end
end
