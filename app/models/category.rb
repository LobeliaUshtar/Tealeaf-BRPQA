class Category < ActiveRecord::Base
  has_many :videos

  validates :name, presence: true

  def recent_videos
    videos.first(6)
  end
end