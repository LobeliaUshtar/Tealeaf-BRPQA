class QueueItemsController < ApplicationController
  before_filter :require_user
  
  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])
    queue_video(@video)
    redirect_to queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    current_user.normalize_queue_item_position
    redirect_to queue_path
  end

  def update
    begin
      update_queue_items
      current_user.normalize_queue_item_position
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid position number."
    end
    redirect_to queue_path
  end

  private
    def queue_video(video)
      @queue_item = QueueItem.create(video: @video, user: current_user, position: new_queue_spot) unless current_user_queued?(@video)
    end

    def new_queue_spot
      current_user.queue_items.count + 1
    end

    def current_user_queued?(video)
      current_user.queue_items.map(&:video).include?(video)
    end

    def update_queue_items
      ActiveRecord::Base.transaction do
        params[:queue_items].each do |data|
          queue_item = QueueItem.find(data["id"])
          queue_item.update_attributes!(position: data["position"], rating: data["rating"]) if queue_item.user == current_user
        end
      end
    end
  # private end
end