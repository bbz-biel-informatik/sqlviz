class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @pages = current_user.pages.all
  end

  def show
    @page = current_user.pages.find(params[:id])
  end

  def new
    @page = current_user.pages.new
  end

  def edit
    @page = current_user.pages.find(params[:id])
  end

  def update
    page = current_user.pages.find(params[:id])
    page.update(page_params)
    redirect_to edit_page_path(page)
  end

  private

  def page_params
    params.require(:page).permit(:name, :css)
  end
end
