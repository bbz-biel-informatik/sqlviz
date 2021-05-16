class VisualsController < ApplicationController
  def create
    page = current_user.pages.find(params[:page_id])

    page.visuals.create(type: visual_params[:type])

    redirect_to edit_page_path(page)
  end

  def update
    visual = current_user.visuals.find(params[:id])
    visual.update(visual_params)
    redirect_to edit_page_path(visual.page)
  end

  private

  def visual_params
    params.require(:visual).permit(:name, :type, queries_attributes: [:id, :query, :_destroy])
  end
end
