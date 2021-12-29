class QuestionsController < ApplicationController
  before_action :find_question, only: %i[show]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render plain: Question.where(test_id: params[:test_id]).inspect
  end

  def show
    render plain: @question.inspect
  end

  def new
  end

  def create
    question = Question.create(question_params.merge(test_id: params[:test_id]))
    render plain: question.inspect
  end

  def destroy
    @question.destroy
    render plain: "Вопрос удален"
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def find_question
    @question = Question.find_by!(id: params[:id], test_id: params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found'
  end
end
