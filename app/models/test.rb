class Test < ApplicationRecord
  class << self
    def self.tests(category)
      joins('JOIN categories ON tests.category_id == categories.id')
      .where(categories: {name: category})
      .select(:id, :title)
      .order('title DESC')
      .pluck('title')
    end
  end
end