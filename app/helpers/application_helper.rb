module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    link_to "github.com",
            "https://github.com/#{author}/#{repo}",
            rel: 'nofollow noopener',
            target: '_blank'
  end

  def school_url(url, title)
    link_to title,
            url,
            rel: "nofollow noopener",
            target: "_blank"
  end
end
