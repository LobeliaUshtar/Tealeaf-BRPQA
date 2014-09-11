class Video < ActiveRecord::Base
  belongs_to :category

  has_many :reviews, ->{order("created_at DESC")}
  has_many :queue_items, ->{order("position")}

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    adapter_type = connection.adapter_name.downcase.to_sym
    case adapter_type
      when :mysql
        # do the MySQL part
      when :sqlite
        where('title LIKE ?', "%#{search_term}%").order('created_at DESC')
      when :postgresql
        where('title ILIKE ?', "%#{search_term}%").order('created_at DESC')
      else
        raise NotImplementedError, "Unknown adapter type '#{adapter_type}'"
    end
  end
end