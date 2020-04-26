class BestseatController < ApplicationController
  before_action :permit_params

  def show
    count = params[:count]
    available_seats = params[:venue_data]
    # head :bad_request unless count && available_seats

    new_venue = Venue.new available_seats
    best_seats = new_venue.find_best_available_seats count
    puts best_seats
    render json: best_seats
  end

  def permit_params
    params.permit!
  end
end
