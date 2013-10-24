class Admin::DatabaseController < Admin::ApplicationController
  def import
    Hotel.import(params[:file])
    redirect_to [:admin, :root], notice: "Hotels imported."
  end
end