require 'digest/sha1'

class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :created_tests, class_name: 'Test', inverse_of: 'author', dependent: :destroy
  has_many :tests_users, dependent: :destroy
  has_many :tests, through: :tests_users
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  validates :login, presence: true, length: { maximum: 255 },
            uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
