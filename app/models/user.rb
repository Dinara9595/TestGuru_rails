class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', inverse_of: 'author', dependent: :destroy
  has_many :tests_users, dependent: :destroy
  has_many :tests, through: :tests_users
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  validates :login, :password, presence: true, uniqueness: true

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
