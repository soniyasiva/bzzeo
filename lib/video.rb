module VideoModule
  def extract_video_id url
    if url.include? 'youtu'
      id = url.split('/')[-1] if url.include? 'youtu.be'
      id = url.split('v=')[-1].split('&')[0] if url.include? 'v='
    elsif url.include? 'vimeo'
      id = url.split('/')[-1].split('?')[0]
    end
    return id
  end
end
