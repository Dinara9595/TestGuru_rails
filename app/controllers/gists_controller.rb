class GistsController < ApplicationController

  def create
    test_passage = TestPassage.find(params[:test_passage_id])
    result = GistQuestionService.new(test_passage.current_question).call
    if result.nil?
      flash[:alert] = t('.failure')
    else
      Gist.create!(question: test_passage.current_question, gist_url: result.html_url, user: current_user)
      flash[:notice] = t('.success', gist_url: result.html_url)
    end
    redirect_to test_passage
  end
end
