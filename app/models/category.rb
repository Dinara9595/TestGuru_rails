class Category < ApplicationRecord
  default_scope { order(name: :asc) }

  has_many :tests, dependent: :destroy

  validates :name, presence: true

  def self.only_name
    pluck(:name)
  end
end
