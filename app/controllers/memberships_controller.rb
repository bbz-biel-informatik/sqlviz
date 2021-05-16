class MembershipsController < ApplicationController
  def create
    page = current_user.pages.find(params[:page_id])

    email = membership_params[:email]
    user = User.find_by(email: email)

    if !user
      redirect_to edit_page_path(page), alert: 'Benutzer wurde nicht gefunden' and return
    end

    Membership.create!(user: user, page: page)

    redirect_to edit_page_path(page), notice: 'Benutzer wurde hinzugefügt' and return
  end

  private

  def membership_params
    params.require(:membership).permit(:email)
  end
end
