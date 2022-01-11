class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :count_answers, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def count_answers
    errors.add(:answers) if question.answers.count >= 4
  end
end
