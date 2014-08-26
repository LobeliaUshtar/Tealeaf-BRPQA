class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews
  has_many :queue_items, ->{order("position")}

  validates_presence_of :email, :full_name
  validates_uniqueness_of :email

  def normalize_queue_item_position
    queue_items.each_with_index do |item, index|
      item.update_attributes(position: index+1)      
    end
  end
end