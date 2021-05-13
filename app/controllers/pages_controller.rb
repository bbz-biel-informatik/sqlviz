class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    page = Page.find(params[:id])
    page.update(page_params)
    redirect_to edit_page_path(page)
  end

  private

  def page_params
    params.require(:page).permit(:name, :css)
  end
end
