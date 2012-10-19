module ApplicationHelper

  def url_omitize(comment)
    length = comment.length
    if length >= 30
      comment[0, 30] + "..."
    else
      comment
    end
  end

end
