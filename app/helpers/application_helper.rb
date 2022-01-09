module ApplicationHelper
  def current_year
    Time.now.year
  end

  def github_url(author, repo)
    link_to "github.com",
            "https://github.com/#{author}/#{repo}",
            rel: 'nofollow noopener',
            target: '_blank'
  end
end
