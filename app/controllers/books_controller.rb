class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @filtered = false
    if(params[:author].nil? or params[:author].empty?)
      @books = Book.all
    else
      @filtered = true
      @books = Book.where(author: params[:author])
    end

    @ratings = []
    if(params[:rating].present?)
      @filtered = true
      booksAboveRating = []
      @books.each do |b|
        reviews = Review.where(book_id: b.id)
        if(reviews.present?)
          rating = (reviews.map(&:rating).inject(:+).to_f)/reviews.size
          if(rating >= params[:rating].to_f)
            booksAboveRating.push(b)
            @ratings.push(rating)
          end
        end
      end
      @books = booksAboveRating
    else
      @books.each do |b|
        reviews = Review.where(book_id: b.id)
        if(reviews.empty?)
          @ratings.push("No reviews yet")
        else 
          @ratings.push((reviews.map(&:rating).inject(:+).to_f)/reviews.size)
        end
      end
    end
  end

  # GET /books/1 or /books/1.json
  def show
    if current_admin.present?
      @is_a_admin = true
    elsif current_user.present?
      @is_a_admin = false
      cart = Cart.where(user_id: current_user.id).order("created_at").last
      cart_detail = CartDetail.where(cart_id: cart.id, book_id: @book.id)
      if cart_detail.empty?
        @alreadyPresent = false 
      else
        @alreadyPresent = true 
      end
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :author, :publisher, :price, :stock)
    end
end
