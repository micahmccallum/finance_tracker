class StocksController < ApplicationController
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def search
    if params[:stock].present?

      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol"
          format.js { render partial: 'users/result' }
        end        
      end    
    else      
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol"
        format.js { render partial: 'users/result' }
      end
    end
  end
end