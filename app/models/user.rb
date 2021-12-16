class User < ApplicationRecord
  def tests(level)
    Test.joins('JOIN passed_tests ON tests.id == test_id')
        .where(passed_tests: {user_id: self.id}, tests: {level: level})
  end
end