class Test < ApplicationRecord
  def self.title_tests(name_category)
    joins('JOIN categories ON tests.category_id == categories.id')
    .where(categories: {name: name_category})
    .select(:id, :title)
    .order('title DESC')
    .pluck('title')
  end
end