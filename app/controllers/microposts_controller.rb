class MicropostsController < ApplicationController
  def create
    if params[:tofinal].index("@") == nil
      @user = User.find_by_name(params[:tofinal])

      if !@user
        redirect_to :back, alert: "Unable to locate user named \"#{params[:tofinal]}\""
      else
        redirect_to :back, notice: "Successfully sent a message to \"#{params[:tofinal]}\""
      end
    else
      arguments = {
        from: "noreply@thousandsoft.com",
        to: params[:tofinal],
        subject: "Message from #{current_user.name}: #{params[:subjectfinal]}",
        html:
        "<a href=http://www.thousandsoft.com target=\"_blank\">See the Message</a>
        <br>
        <img src=http://www.thousandsoft.com/bcn-w.jpg></img>
        "
      }
      Mailgun().messages.send_email(arguments)
      redirect_to :back, notice: "Successfully send a message to \"#{params[:tofinal]}\""
    end

  end

  def destroy
    @micropost = current_user.microposts.where(:id => params[:id]).first
    if @micropost.present?
      @micropost.destroy
      flash[:success] = "Micropost deleted!"
    end
    # in both cases, redirect to root_path
    redirect_to :back
  end

  def send_msg_form
  end

  def send_msg
  end


end
