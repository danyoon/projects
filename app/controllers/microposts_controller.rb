class MicropostsController < ApplicationController

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      redirect_to root_url, :flash => { :success => "Micropost created!" }
    else
      @feed_items = []
      render 'static_pages/index'
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

  def send_user_form
  end

  def send_user
    if params[:user].index("@") == nil
      @user = User.find_by_name(params[:user])

      if !@user
        redirect_to :back, alert: "Can't find user named \"#{params[:user]}\""
      else
        redirect_to :back, notice: "Successfully sent a message to \"#{params[:user]}\""
      end
    else
      permlink = current_user.hotel_permlinks.generate!(@hotel)
      link = Rails.application.routes.url_helpers.permlink_url(permlink)

      arguments = {
        from: "noreply@thousandsoft.com",
        to: params[:user],
        subject: "#{current_user.name} has sent you a message",
        html: "see the <a href=\"#{link}\" target=\"_blank\">link</a>"
      }

      Mailgun().messages.send_email(arguments)

      redirect_to :back, notice: "Successfully send a message to \"#{params[:user]}\""
    end
  end
end
