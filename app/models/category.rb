class Category < ApplicationRecord
  has_many :tests, dependent: :destroy

  default_scope { order(name: :asc)}

  validates :name, presence: true, uniqueness: true
end
