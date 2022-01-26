require 'digest/sha1'

class User < ApplicationRecord

  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages, source: :test

  validates :login, presence: true, length: { maximum: 255 },
            uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
