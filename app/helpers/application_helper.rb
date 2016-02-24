include Video

module ApplicationHelper

  # generates html for embedding videos
  # swoosh is a ui element
  # hidden is for not preloading the video
  def embed video_object, swoosh=false, hidden=false, ratio='16by9'
    case video_platform? video_object.video_url
    when 'vimeo'
      html = "<div class=\"embed-responsive embed-responsive-#{ratio}\">"
      html << "<img src=\"https://ucarecdn.com/e58cd11e-0100-47f1-ab55-a27a4f0f1f41/\" class=\"triangle-swoosh img-responsive visible-xs\"/>" if swoosh
      html << "<iframe data-id=\"#{video_object.id}\" class=\"embed-responsive-item #{"collapse" if hidden}\" src=\"https://player.vimeo.com/video/#{video_object.video_url}?title=0&byline=0&portrait=0&badge=0\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div>"
    when 'youtube'
      html = "<div class=\"embed-responsive embed-responsive-#{ratio}\">"
      html << "<img src=\"https://ucarecdn.com/e58cd11e-0100-47f1-ab55-a27a4f0f1f41/\" class=\"triangle-swoosh img-responsive visible-xs\"/>" if swoosh
      html << "<iframe data-id=\"#{video_object.id}\" class=\"embed-responsive-item #{"collapse" if hidden}\" src=\"https://www.youtube.com/embed/#{video_object.video_url}\" frameborder=\"0\" allowfullscreen></iframe></div>"
    else
      nil
    end
  end

  def city address
    return nil if address.blank?
    address.split(',').last(2).join(',')
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

  # menu active helper
  def active? check_path
    return 'active' if request.path == check_path
    ''
  end

  # helper for controller and action specific css
  def styles
    "controller-#{params[:controller].gsub '/', '-'} action-#{params[:action]} id-#{params[:id] ? params[:id] : 'none'}"
  end

end
