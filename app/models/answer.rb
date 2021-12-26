class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true, uniqueness: true
  validate :count_answers, on: :create

  scope :correct_answer, -> {where(correct: true)}

  private

  def count_answers
    errors.add(:answers) if question.answers.count >= 4
  end
end
