class MicropostsController < ApplicationController
  def create

    redirect_to :back,  notice: "Successfully send a message"
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
  end

  def send_msg
    if params[:to].index("@") == nil
      @user = User.find_by_name(params[:to])

      if !@user
        redirect_to :back, alert: "Can't find user named \"#{params[:user]}\""
      else
        redirect_to :back, notice: "Successfully sent a message to \"#{params[:user]}\""
      end
    else
      arguments = {
        from: "noreply@thousandsoft.com",
        to: "zeradan@gmail.com",
        subject: "From #{current_user.name}: #{params[:subject]}",
        html: "From #{current_user.name}: #{params[:message]}"
      }
      Mailgun().messages.send_email(arguments)
      redirect_to :back, notice: "Successfully send a message to \"#{params[:user]}\""
    end
  end
end
