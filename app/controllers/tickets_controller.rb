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

  def destroy
    ticket = current_user.tickets.find_by!(event_id: params[:event_id])
    ticket.destroy!
    redirect_to event_path(params[:event_id]), notice: 'このイベントへの参加をキャンセルしました'
  end
end
