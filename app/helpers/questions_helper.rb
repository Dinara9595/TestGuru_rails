module QuestionsHelper
  def question_header(question)
    if question.persisted?
      operation = "Edit"
    else
      operation = "Create New"
    end
    "#{operation} #{question.test.title} Question"
  end
end
