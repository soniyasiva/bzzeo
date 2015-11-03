module ApplicationHelper
  def build_video_embed video_id
    "<iframe src=\"https://www.youtube.com/embed/#{video_id}\" frameborder=\"0\" allowfullscreen></iframe>"
  end
end
