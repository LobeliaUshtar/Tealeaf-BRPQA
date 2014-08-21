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

  private
    def queue_video(video)
      @queue_item = QueueItem.create(video: @video, user: current_user, order: new_queue_spot) unless current_user_queued?(@video)
    end

    def new_queue_spot
      current_user.queue_items.count + 1
    end

    def current_user_queued?(video)
      current_user.queue_items.map(&:video).include?(video)
    end
  # private end
end