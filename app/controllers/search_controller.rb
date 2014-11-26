include Amatch

class SearchController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board

  def index
  end

  def search
    @query = params[:query].strip
    @response = {}
    if @query.to_s == @query
      #check for exact match
      @good_matches = {}
      exact_match_by_key = Project.find_by_experiment_key(@query)
      exact_match_by_name = Project.find_by_name(@query)

      if !exact_match_by_key.nil? && exact_match_by_key.initiative.board.id.to_s == @board_id
        @good_matches = {exact_match_by_key => 1}
      end

      if !exact_match_by_name.nil? && exact_match_by_name.initiative.board.id.to_s == @board_id
        @good_matches = {exact_match_by_name => 1}
      end

      if @good_matches.count == 0
        # store project keys
        Project.all.each do |p|
          if p.initiative && !p.initiative.standing? && (@board_id.nil? || (p.board_identifier.to_s == @board_id))
            # find "good matches"
            project_key = p.experiment_key
            project_name = p.name

            amatch = LongestSubstring.new(@query)
            score = project_key ? [amatch.match(project_key), amatch.match(project_name)].max : amatch.match(project_name)

            if score > 2
              @good_matches[p] = score
            end
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
      redirect_to board_search_index_path, alert: "No projects found! Try being more specific"
    else #more than 1 good match
      render "search_results"
    end
  end

  private
  def set_board
    @board_id = params[:board_id]
  end


end