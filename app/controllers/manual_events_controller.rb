class ManualEventsController < ApplicationController
  def create
    game = Game.find(params[:game_id])

    game.manual_events.create(
      event_type: params[:event_type]
    )

    render json: {success: true}
  end
end
