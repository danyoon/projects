class MicropostsController < ApplicationController
  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    arguments = {
        from: "noreply@thousandsoft.com",
        to: "#{one}",
        subject: "#{current_user.name} has sent you a message",
        html: "#{three}"
      }
    Mailgun().messages.send_email(arguments)

    if @micropost.save
      redirect_to root_url, :flash => { :success => "Micropost created!" }
    else
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

  def send_msg_form
    @micropost = current_user.microposts.build(params[:micropost])    
  end

  def send_msg
    if params[:user].index("@") == nil
      @user = User.find_by_name(params[:user])

      if !@user
        redirect_to :back, alert: "Can't find user named \"#{params[:user]}\""
      else
        redirect_to :back, notice: "Successfully sent a message to \"#{params[:user]}\""
      end
    else

      redirect_to :back, notice: "Successfully send a message to \"#{params[:user]}\""
    end
  end
end
