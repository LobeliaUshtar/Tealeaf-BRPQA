class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params.merge!(user: current_user))

    if @review.save
      flash[:success] = "Thank you for your review."
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      flash[:danger] = "Invalid email and/or password."
      render 'videos/show'
    end
    
  end

  private
    def review_params
      params.require(:review).permit!
    end
  # private end
end