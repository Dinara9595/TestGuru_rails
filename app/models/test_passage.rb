class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true, foreign_key: 'question_id'

  before_validation :set_current_question

  SUCCESS_RATIO = 85

  def accept!(answer_ids)
    return if time_over?

    self.correct_questions +=1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil? || time_over?
  end

  def successful?
    percent >= SUCCESS_RATIO
  end

  def percent
    ((correct_questions.to_f / total_question_number.to_f ) * 100).to_i
  end

  def current_question_number
    test.questions.order(:id).where('id < ?', current_question.id).size + 1
  end

  def total_question_number
    test.questions.count
  end

  def timer_left_time
    timer_finish_time - Time.now
  end

  def timer_finish_time
    created_at.to_time + test.timer * 60
  end

  def time_over?
    timer_left_time <= 0
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
