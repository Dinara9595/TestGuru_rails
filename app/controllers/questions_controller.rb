class QuestionsController < ApplicationController
  before_action :find_test
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render plain: @test.questions.inspect
  end

  def show
    render plain: @question.inspect
  end

  def new
  end

  def create
    question = @test.questions.build(question_params)
    if question.save
      render plain: "Вы создали вопрос: #{question.inspect}"
    else
      render :new
    end
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
    @question = @test.questions.find_by!(id: params[:id])
  end

  def find_test
    @test = Test.find_by!(id: params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found'
  end
end
