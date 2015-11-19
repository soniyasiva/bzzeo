include Video

module ApplicationHelper

  # generates html for embedding videos
  def embed video_object, hidden=false
    case video_platform? video_object.video_url
    when 'vimeo'
      "<iframe data-id=\"#{video_object.id}\" class=\"#{"collapse" if hidden}\" src=\"https://player.vimeo.com/video/#{video_object.video_url}?title=0&byline=0&portrait=0&badge=0\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
    when 'youtube'
      "<iframe data-id=\"#{video_object.id}\" class=\"#{"collapse" if hidden}\" src=\"https://www.youtube.com/embed/#{video_object.video_url}\" frameborder=\"0\" allowfullscreen></iframe>"
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
