class ManualEventsController < ApplicationController
  def create
    game = Game.find(params[:game_id])

    new_event = game.manual_events.new(
      event_type: params[:event_type],
      ip_address: request.remote_ip
    )

    if new_event.save
      Pusher.trigger("game-#{game.id}", 'new-event', {
        clock:       " ",
        period:      " ",
        event_type:  new_event.event_type,
        wall_clock:  new_event.wall_clock.to_mst_time,
        description: new_event.description,
      })
      render json: { success: true }
    else
      render json: { success: false }
    end

  end
end
