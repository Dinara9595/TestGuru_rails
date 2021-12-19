class Test < ApplicationRecord
  has_many :questions
  belongs_to :category
  has_many :tests_users
  has_many :users, through: :tests_users
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def self.title_tests(name_category)
    joins('JOIN categories ON tests.category_id == categories.id')
    .where(categories: {name: name_category})
    .order('title: :DESC')
    .pluck('title')
  end
end