class CurrenciesController < ApplicationController
  before_action :set_currency, only: [:open_modal, :buy, :show, :edit, :update, :destroy]
  before_action :authorize

  # GET /currencies
  # GET /currencies.json
  def index
    @currencies = Currency.where.not(default: true)
  end

  # GET /currencies/1
  # GET /currencies/1.json
  def show
  end

  def buy
    #take params from modal
    final_currency_id = params[:final_currency_id]
    final_currency_amount = params[:final_currency_amount].to_f

    original_currency_id = params[:original_currency_id]
    cost = params[:cost].to_f

    #take the user current amount
    original_amount = Amount.find_by(user_id: current_user.id, currency_id: original_currency_id)
  
    if original_amount.quantity < cost then 
      #if the user doesn't have enough money to buy then
      redirect_to currencies_path, notice: "You don't have enough coins to buy"
    else
    #if there is enough quantity then 

      #create amount
      Amount.create(
        currency_id: final_currency_id,
        quantity: final_currency_amount,
        user_id: current_user.id
      )

      #create transaction
      Transaction.create(
        user_id: current_user.id,
        original_currency_id: original_currency_id,
        original_currency_amount: original_amount.quantity,
        final_currency_id: final_currency_id,
        final_currency_amount: final_currency_amount
        )

        #update the quantity of the original amount

        original_amount.update(
          quantity: (original_amount.quantity - cost)
        )

      redirect_to currencies_path, notice: 'Successfully bought some coins'
    end
  end

  # GET /currencies/new
  def new
    @currency = Currency.new
  end

  def open_modal
    @amount = params[:quantity].to_i

    render :partial => 'render_modal'    
  end

  # GET /currencies/1/edit
  def edit
  end

  # POST /currencies
  # POST /currencies.json
  def create
    @currency = Currency.new(currency_params)

    respond_to do |format|
      if @currency.save
        format.html { redirect_to @currency, notice: 'Currency was successfully created.' }
        format.json { render :show, status: :created, location: @currency }
      else
        format.html { render :new }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currencies/1
  # PATCH/PUT /currencies/1.json
  def update
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to @currency, notice: 'Currency was successfully updated.' }
        format.json { render :show, status: :ok, location: @currency }
      else
        format.html { render :edit }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currencies/1
  # DELETE /currencies/1.json
  def destroy
    @currency.destroy
    respond_to do |format|
      format.html { redirect_to currencies_url, notice: 'Currency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_params
      params.require(:currency).permit(:name, :symbol, :default)
    end
end
