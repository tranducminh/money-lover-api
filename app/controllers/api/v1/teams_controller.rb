class Api::V1::TeamsController < ApplicationController
  before_action :authenticate_request!
  before_action :find_team, only: [:show, :update, :destroy]

  def index
    @teams = current_user.teams
  end

  def create
    @team = current_user.teams.create!(create_params)
  end

  def update
    return render_error :forbidden, "Not allow to update this team" if current_user.id != @team.owner_id

    @team.update!(update_params)
  end

  def destroy
    return render_error :forbidden, "Not allow to delete this team" if current_user.id != @team.owner_id

    @team.destroy
  end

  private

  def find_team
    @team = Team.find(params[:id])

    render_error :not_found, "Team ##{params[:id]} not_found" unless @team
  end

  def create_params
    params.permit(Team::CREATE_PARAMS)
  end

  def update_params
    params.permit(Team::UPDATE_PARAMS)
  end
end
