class Admin < User
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :created_badges, class_name: 'Badge', foreign_key: 'author_badge_id', dependent: :destroy
end
