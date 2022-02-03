class GistsController < ApplicationController
  def create
    test_passage = TestPassage.find(params[:test_passage_id])
    result = GistQuestionService.new(test_passage.current_question).call
    if result.success?
      Gist.create!(question: test_passage.current_question, gist_url: result.gist_url, user: current_user)
      link = view_context.link_to('gists', result.gist_url, rel: "nofollow noopener", target: "_blank")
      flash_options = { notice: t('.success', gist_url: link)}
    else
      flash_options = { alert: t('.failure') }
    end
    redirect_to test_passage, flash_options
  end
end
