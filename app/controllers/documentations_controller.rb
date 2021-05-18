class DocumentationsController < ApplicationController
  def show
    filename = params[:id]
    path = "app/views/documentations/#{filename}.html"

    if !File.exist?(path)
      raise ActionController::RoutingError.new('Not Found')
    end

    @content = File.read(path)
  end
end
