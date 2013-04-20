class PricesController < ApplicationController

  def destroy
    @price = current_user.prices.where(:id => params[:id]).first
    if @price.present?
      @price.destroy
      flash[:success] = "Price deleted!"
    end
  end
end
