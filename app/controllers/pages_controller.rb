class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:form]

  def index
    @pages = current_user.pages.all
  end

  def show
    @page = current_user.pages.find(params[:id])
  end

  def new
    @page = current_user.pages.new
  end

  def create
    page = current_user.pages.create(page_params)
    redirect_to edit_page_path(page)
  end

  def edit
    @page = current_user.pages.find(params[:id])
  end

  def update
    page = current_user.pages.find(params[:id])
    page.update(page_params)
    redirect_to edit_page_path(page)
  end

  def form
    
  end

  private

  def page_params
    params.require(:page).permit(:name, :css)
  end
end
