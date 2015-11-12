include Video

module ApplicationHelper

  # generates html for embedding videos
  def embed video_id
    case video_platform? video_id
    when 'vimeo'
      "<iframe src=\"https://player.vimeo.com/video/#{video_id}?title=0&byline=0&portrait=0&badge=0\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
    when 'youtube'
      "<iframe src=\"https://www.youtube.com/embed/#{video_id}\" frameborder=\"0\" allowfullscreen></iframe>"
    else
      nil
    end
  end

  # generates standard viewing urls for videos
  def render_url video_id
    case video_platform? video_id
    when 'vimeo'
      "https://vimeo.com/#{video_id}"
    when 'youtube'
      "https://youtu.be/#{video_id}"
    else
      nil
    end
  end

end
