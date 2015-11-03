module VideoModule
  # https://youtu.be/HK0pBDZiWgk
  # https://www.youtube.com/watch?v=HK0pBDZiWgk
  # https://www.youtube.com/watch?v=HK0pBDZiWgk&ok=nok
  # convert to
  # <iframe width="560" height="315" src="https://www.youtube.com/embed/HK0pBDZiWgk" frameborder="0" allowfullscreen></iframe>

  def extract_video_id url
    return nil unless url.include? 'youtu'
    id = url.split('/')[-1] if url.include? 'youtu.be'
    id = url.split('v=')[-1].split('&')[0] if url.include? 'v='
    return id
  end
end
