class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[ show edit update destroy ]

  # GET /purchases or /purchases.json
  def index
    @purchases = Purchase.where(user_id: current_user.id)
    @books = []
    @purchases.each do |p|
      cart_details = CartDetail.where(cart_id: p.cart_id)
      temp = []
      cart_details.each do |cd|
        temp.push([cd.book.name, cd.quantity])
      end
      @books.push(temp) 
    end
    puts "here", @books
  end

  # GET /purchases/1 or /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @cart_id = Cart.where(user_id: current_user.id).order("created_at").last.id
    cart_details = CartDetail.where(cart_id: @cart_id).map(&:quantity)
    book_prices = CartDetail.where(cart_id: @cart_id).map(&:book).map(&:price)
    @total_price = cart_details.zip(book_prices).map{|x, y| x * y}.inject(:+)
    @purchase = Purchase.new

    values_to_check = [:credit_card, :address, :phone_number]
    @values_to_notify = []

    # Prefill values else notify
    values_to_check.each do |val|
      unless current_user.send(val).nil? or current_user.send(val).empty?
        @purchase.send((val.to_s + '=').to_sym, current_user.send(val))
      else
        @values_to_notify << val
      end
    end

    user = User.find_by(id: current_user.id)
    @credit_card = user.credit_card.to_s
    @phone_number = user.phone_number
    @address = user.address

    puts @credit_card
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases or /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    quantity_details = CartDetail.where(cart_id: purchase_params[:cart_id]).map(&:quantity)
    book_ids = CartDetail.where(cart_id: purchase_params[:cart_id]).map(&:book_id)
    books = Book.where(id: book_ids)

    books.each_with_index do |b, i| 
      books[i].stock = books[i].stock - quantity_details[i]
      if books[i].stock < 0
        flash[:notice] = 'Someone else checked out before; please update quantities to continue with purchase!'
        redirect_to cart_details_path
        return
      end
    end

    books.each do |b|
      b.save!
    end
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to purchase_url(@purchase), notice: "Purchase was successfully created." }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1 or /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to purchase_url(@purchase), notice: "Purchase was successfully updated." }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1 or /purchases/1.json
  def destroy
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url, notice: "Purchase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_params
      params.require(:purchase).permit(:credit_card, :phone_number, :address, :total_price, :user_id, :cart_id)
    end
end
