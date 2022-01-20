module TestPassagesHelper

  def total_number_answers(test_passage)
    test_passage.test.questions.joins(:answers).where(answers: {correct: true}).distinct.count #либо можно просто делить на количество вопросов в тесте
  end

  def actual_number_answers(test_passage)
    test_passage.correct_questions
  end

  def percent(test_passage)
    total_number = total_number_answers(test_passage)
    actual_number = actual_number_answers(test_passage)
    ((actual_number.to_f / total_number.to_f ) * 100).to_i
  end

  def current_question_number(test_passage)
    test_passage.test.questions.index(test_passage.current_question) + 1
  end

  def total_question_number(test_passage)
    test_passage.test.questions.count
  end
end
