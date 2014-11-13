class SearchController < ApplicationController

  def index
  end

  def search
    @query = params[:query].strip
    @response = {}
    if @query.to_s == @query
      begin
        response = Project.where(:experiment_key => @query)
      rescue
        response = nil
      end
      handle_response(response, response.count)
    end
  end

  def handle_response(response, count)
    if count == 1
      if request.xhr?
        render :js => "window.location = '/wtf'"
      else
        board_id = response.first.board_identifier
        project_id = response.first.id
        redirect_to "/boards/#{board_id}/projects/#{project_id}/edit"
      end
    elsif count == 0
      redirect_to "/search/index", notice: "No projects found!"
    else
      redirect_to "/search/index", notice: "Multiple projects found!"
    end
  end
end