class Video < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    if search_term.blank?
      []
    else
      where(["title #{DATABASE_OPERATOR[:like_operator]} ?", "%#{search_term}%"]).order("created_at DESC")
    end
  end
end