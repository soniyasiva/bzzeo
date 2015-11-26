module Video

  # get the video id from a url
  def extract_video_id url
    return nil if url.nil?
    if url.include? 'youtu'
      id = url.split('/')[-1] if url.include? 'youtu.be'
      id = url.split('v=')[-1].split('&')[0] if url.include? 'v='
    elsif url.include? 'vimeo'
      id = url.split('/')[-1].split('?')[0]
    end
    return id
  end

  # checks the provider of the video
  def video_platform? video_id
    if /\A\d+\z/.match(video_id) # checks if the id is only numbers
      'vimeo'
    elsif video_id.blank?
      nil
    else
      'youtube'
    end
  end

  # get the thumbnail for vimeo or youtube
  def get_thumbnail video_id
    case video_platform? video_id
    when 'vimeo'
      video = Vimeo::Simple::Video.info(video_id)
      video.parsed_response.first["thumbnail_large"]
    when 'youtube'
      "https://img.youtube.com/vi/#{video_id}/sddefault.jpg"
    else
      nil
    end
  end

end
