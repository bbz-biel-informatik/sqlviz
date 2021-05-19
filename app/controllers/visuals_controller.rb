class VisualsController < ApplicationController
  def create
    page = current_user.pages.find(params[:page_id])

    page.visuals.create(type: visual_params[:type])

    redirect_to edit_page_path(page)
  end

  def update
    visual = current_user.visuals.find(params[:id])
    visual.update(visual_params)

    respond_to do |format|
      format.html { redirect_to edit_page_path(visual.page) }
      format.js
    end
  end

  def destroy
    visual = current_user.visuals.find(params[:id])
    visual.destroy

    redirect_to edit_page_path(visual.page)
  end

  def sort
    ids = JSON.parse(params[:sort])
    positions = ids.each_with_index.map { |id, idx| { position: idx } }

    current_user.visuals.update(ids, positions)
  end

  private

  def visual_params
    params.require(:visual).permit(:name, :type, :klass, :description, queries_attributes: [:id, :query, :_destroy])
  end
end
