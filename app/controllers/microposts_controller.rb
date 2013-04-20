class MicropostsController < ApplicationController

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      redirect_to root_url, :flash => { :success => "Micropost created!" }
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = current_user.microposts.where(:id => params[:id]).first
    if @micropost.present?
      @micropost.destroy
      flash[:success] = "Micropost deleted!"
    end
    # in both cases, redirect to root_path
    redirect_to root_url
  end
end
