class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to root_path, notice: 'レビューを投稿しました'
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def review_params
    params.require(:review).permit(:pre_review).merge(book_id: params[:book_id])
  end
end
