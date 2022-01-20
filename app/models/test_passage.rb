class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true, foreign_key: 'question_id'

  before_validation :set_current_question

  SUCCESS_RATIO = 85

  def accept!(answer_ids)
    self.correct_questions +=1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def successful?(percent)
    percent >= SUCCESS_RATIO
  end

  def percent(test_passage)
    total_number = total_question_number(test_passage)
    ((test_passage.correct_questions.to_f / total_number.to_f ) * 100).to_i
  end

  def current_question_number(test_passage)
    test_passage.test.questions.order(:id).where('id < ?', current_question.id).size + 1
  end

  def total_question_number(test_passage)
    test_passage.test.questions.count
  end

  private

  def set_current_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    if current_question
      test.questions.order(:id).where('id > ?', current_question.id).first
    else
      test.questions.first if test.present?
    end
  end
end
