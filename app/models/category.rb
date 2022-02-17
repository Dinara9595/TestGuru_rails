class Category < ApplicationRecord
  default_scope { order(name: :asc) }

  has_many :tests, dependent: :destroy

  validates :name, presence: true

  def self.only_name
    category_name = []
    self.all.each { |category| category_name << category.name }
    category_name
  end
end
