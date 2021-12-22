class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', inverse_of: 'author', dependent: :destroy
  has_many :tests_users, dependent: :destroy
  has_many :tests, through: :tests_users

  def level_tests(level)
    tests.where(level: level)
  end
end
