class Answer < ApplicationRecord
  belongs_to :question

  scope :choice_of_answer, -> {where(correct: true)}

  validates :body, presence: true, uniqueness: true
  validate :count_answers

  private

  def count_answers
    errors.add(:answers) if question.answers.size == 4
  end
end
