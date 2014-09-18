module ApplicationHelper
  
  def nl2br(s)
    s.gsub(/\n/, '<br>')
  end
  
  def date_with_slashes(date)
    "#{date.month}/#{date.day}/#{date.year}"
  end
  
end
