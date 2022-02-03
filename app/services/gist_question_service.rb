class GistQuestionService
  Result = Struct.new(:success?, :gist_url)

  def initialize(question)
    @question = question
    @test = @question.test
    @client = Octokit::Client.new({:access_token => Rails.application.credentials.access_token_octokit})
  end

  def call
    response = @client.create_gist(gist_params)
    Result.new(response.html_url.present?, response.html_url)
  end

  private

  def gist_params
    {
        description: I18n.t('.description', test_title: @test.title),
        files: {
            'test-guru' => {
                content: gist_content
            }
        }
    }
  end

  def gist_content
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end
end
