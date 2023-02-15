class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
    @selectedUser = ""
    @selectedBook = ""
    if(!params[:author].nil?)
      @reviews = Review.where(user_id: params[:author])
      @selectedUser = params[:author]
    elsif(!params[:book].nil?)
      @reviews = Review.where(book_id: params[:book])
      @selectedBook = params[:book]
    end
    @people = User.all
    @book = Book.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    if(@review.user_id)
      @user = User.find_by(id: @review.user_id)
    else
      @admin = Admin.find_by(id: @review.admin_id)
    end
    @book = Book.find_by(id: @review.book_id)
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @book = params[:book_id]
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    rating = review_params['rating']
    review = review_params['review']
    review_params = {"book_id": @review.book_id, "user_id": @review.user_id, "rating": rating, "review": review}
    puts review_params

    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def review_by_admin?
      params[:review][:admin_id] ? true : false
    end

    def admin_id_for_review
      params[:review][:admin_id]
    end

    # Only allow a list of trusted parameters through
    def review_params
      params.require(:review).permit(:rating, :review, :user_id, :book_id, :admin_id)
    end
end
