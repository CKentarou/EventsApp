class TicketsController < ApplicationController
  def new
    raise ActionController::RoutingErro, "ログイン状態でTicketsController#newにアクセス"
  end

  def create
    event = Event.find(params[:event_id])
    @ticket = current_user.tickets.build do |t|
      t.event = event
      t.comment = params[:ticket][:comment]
    end
    if @ticket.save
      redirect_to event, notice: 'チケットを取得しました'
    end
  end
end
