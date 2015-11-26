module ProfilesHelper
  # creates clickable link for phone number
  def tel_to(text)
    groups = text.to_s.scan(/(?:^\+)?\d+/)
    link_to text, "tel:#{groups.join '-'}"
  end
end
