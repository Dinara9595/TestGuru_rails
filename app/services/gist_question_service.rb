class GistQuestionService

  def initialize(question)
    @question = question
    @test = @question.test
    @client = Octokit::Client.new({:access_token => Rails.application.credentials.access_token_octokit})
  end

  def call
    byebug
    @client.create_gist(gist_params)
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
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
