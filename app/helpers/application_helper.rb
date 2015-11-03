module ApplicationHelper
  def embed video_id
    return nil if video_id.blank?
    if /\A\d+\z/.match(video_id) # checks if the id is only numbers
      "<iframe src=\"https://player.vimeo.com/video/#{video_id}?title=0&byline=0&portrait=0&badge=0\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
    else
      "<iframe src=\"https://www.youtube.com/embed/#{video_id}\" frameborder=\"0\" allowfullscreen></iframe>"
    end
  end
end
