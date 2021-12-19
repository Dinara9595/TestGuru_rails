class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users
  has_many :tests, inverse_of: 'author'

  def level_tests(level)
    Test.joins('JOIN passed_tests ON tests.id == test_id')
        .where(passed_tests: {user_id: self.id}, tests: {level: level})
  end
end
