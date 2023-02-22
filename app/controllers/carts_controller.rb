class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]

  def add_to_cart
    cart = Cart.where(user_id: current_user.id).order("created_at").last
    cart_detail = CartDetail.where(cart_id: cart.id, book_id: params[:book_id])
    if cart_detail.empty? 
      CartDetail.create(cart_id: cart.id, book_id: params[:book_id], quantity: params[:quantity])
      respond_to do |format|
        format.html { redirect_to books_url(), notice: "Book was successfully added." }
      end
    else 
      cart_detail.update(quantity: params[:quantity])
      respond_to do |format|
        format.html { redirect_to cart_details_path, notice: "Quantity was successfully updated." }
      end
    end
  end  
  
  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1 or /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end

end
