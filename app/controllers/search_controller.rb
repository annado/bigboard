include Amatch

class SearchController < ApplicationController
  def index
  end

  def search
    @query = params[:query].strip
    @response = {}
    if @query.to_s == @query
      #check for exact match
      @good_matches = {}
      exact_match = Project.find_by_experiment_key(@query)
      if !exact_match.nil?
        @good_matches = {exact_match => 1}
      else
        # store project keys
        Project.where.not(:experiment_key => "").each do |p| 
          # find "good matches"
          key = p.experiment_key
          amatch = Jaro.new(@query)
          if amatch.match(key) > 0.5
            @good_matches[p] = amatch.match(key)
          end
        end
      end
      handle_response(@good_matches, @good_matches.count)
    end
  end

  def handle_response(response, count)
    if count == 1 # only 1 match, go directly to that project
        board_id = response.first[0].board_identifier
        project_id = response.first[0].id
        redirect_to "/boards/#{board_id}/projects/#{project_id}/edit"
    elsif count == 0 # no matches
      redirect_to "/search/index", alert: "No projects found! Try being more specific"
    else #more than 1 good match
      render "search_results"
    end
  end
end