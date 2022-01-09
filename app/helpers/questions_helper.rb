module QuestionsHelper
  def question_header(question, operation)
    "#{operation} #{question.test.title} Question"
  end
end
