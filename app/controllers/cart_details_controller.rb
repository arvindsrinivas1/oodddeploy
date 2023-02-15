class CartDetailsController < ApplicationController
  before_action :set_cart_detail, only: %i[ show edit update destroy ]

  # GET /cart_details or /cart_details.json
  def index
    cart = Cart.where(user_id: current_user.id).order("created_at").last
    @cart_details = CartDetail.where(cart_id: cart.id)
    @cartHasItems = @cart_details.present?
  end

  # GET /cart_details/1 or /cart_details/1.json
  def show
  end

  # GET /cart_details/new
  def new
    @cart_detail = CartDetail.new
  end

  # GET /cart_details/1/edit
  def edit
  end

  # POST /cart_details or /cart_details.json
  def create
    @cart_detail = CartDetail.new(cart_detail_params)

    respond_to do |format|
      if @cart_detail.save
        format.html { redirect_to cart_detail_url(@cart_detail), notice: "Cart detail was successfully created." }
        format.json { render :show, status: :created, location: @cart_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_details/1 or /cart_details/1.json
  def update
    respond_to do |format|
      if @cart_detail.update(cart_detail_params)
        format.html { redirect_to cart_detail_url(@cart_detail), notice: "Cart detail was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_details/1 or /cart_details/1.json
  def destroy
    @cart_detail.destroy

    respond_to do |format|
      format.html { redirect_to cart_details_url, notice: "Cart detail was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_detail
      @cart_detail = CartDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_detail_params
      params.require(:cart_detail).permit(:quantity)
    end
end
