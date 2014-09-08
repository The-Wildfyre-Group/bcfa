class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :destroy
  
  def most_recent_post
    topic = Topic.where(['forum_id = ?', self.id]).map(&:posts).flatten.map(&:created_at).max
  end
  
  def most_recent_poster
    topic = Topic.where(['forum_id = ?', self.id]).map(&:posts).flatten.last.user
  end
  
  def sorted_topics
    topics.sort {|a,b| b.last_post_at <=> a.last_post_at}
  end
  
  def sorted_topics_array
    array = []
    sorted_topics.each do |topic|
      array << topic.id
    end
    array
  end
  
  def next_topic(topic_id)
    index = sorted_topics_array.index(topic_id)
    if sorted_topics_array.size > index && sorted_topics_array[index+1].present?
      topic_id = sorted_topics_array[index+1]
    else
      topic_id = sorted_topics_array.first
    end
    Topic.find(topic_id)
  end
  
end
