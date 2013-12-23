class MicropostsController < ApplicationController
  def create
    arguments = {
        from: "noreply@thousandsoft.com",
        to: "zeradan@gmail.com",
        subject: "From #{current_user.name}: #{params[:two]}",
        html: "From #{current_user.name}: #{params[:three]}"
      }
    Mailgun().messages.send_email(arguments)

    redirect_to :back
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
