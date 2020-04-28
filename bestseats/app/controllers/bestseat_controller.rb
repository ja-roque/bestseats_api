class BestseatController < ApplicationController
  before_action :permit_params

  def venue
    new_venue = build_venue
    render json: new_venue.all_seats
  end

  def seats
    new_venue = build_venue
    render json: new_venue.best_seats
  end

  def permit_params
    params.permit!
  end

  def build_venue
    count = params[:count]&.to_i
    available_seats = params[:venue_data]
    # head :bad_request unless count && available_seats

    new_venue = Venue.new available_seats
    new_venue.get_best_available_seats count
    new_venue
  end
end
