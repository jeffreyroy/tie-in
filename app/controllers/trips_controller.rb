class TripsController < ApplicationController
  helper ApplicationHelper
  skip_before_filter  :verify_authenticity_token

  def index
    @trips = Trip.all

    @json = @trips.map do |trip|
      {
        id: trip.id,
        name: trip.name,
        description: trip.description,
        location: trip.location,
        start_date: trip.start_date,
        end_date: trip.end_date
      }
    end
    render :json => @json
  end

  def show
  end

  def create
    @current_user = User.first # Need to change this once we have an actual current user!
    @newTrip = Trip.new(
        name: params["name"],
        location: params["location"],
        description: params["description"],
        start_date: Date.parse(params["start_date"]),
        end_date: Date.parse(params["end_date"])
      )

    @newTrip.creator_id = @current_user.id
    if @newTrip.save
      render :json =>
      {
        status: "ok",
        message: "Trip saved!",
        object: @newTrip
      }.to_json
    else
      render :json =>
      {
        status: "error",
        message: @newTrip.errors.full_messages.to_sentence,
        object: @newTrip
      }.to_json
    end
  end
end