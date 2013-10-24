class Admin::WelcomeController < Admin::ApplicationController
  before_filter :admin_required?


private
  def admin_required?
    redirect_to :root, notice: "You don't have permission" if !current_user or !current_user.admin
  end
end