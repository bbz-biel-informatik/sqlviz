class VisualsController < ApplicationController
  def update
    visual = current_user.visuals.find(params[:id])
    visual.update(visual_params)
    redirect_to edit_page_path(visual.page)
  end

  private

  def visual_params
    params.require(:visual).permit(:name, queries_attributes: [:id, :query, :_destroy])
  end
end
