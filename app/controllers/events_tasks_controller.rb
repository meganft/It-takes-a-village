class EventsTasksController < ApplicationController

  def edit
    @event = Event.find(params[:id])
    @events_tasks = @event.events_tasks
  end

  def update
    @event = Event.find(params["events_task"]["event_id"])
    @event_task = EventsTask.find(params["events_task"]["event_task_id"])
    @event_task.update(start_time: params["events_task"]["start_time"])
    redirect_to :back
  end

  def event_task_params
    params.require(:event_task).permit(:start_time)
  end

  # def index
  #   @event = Event.find(params[:id])
  #   @events_tasks = @event.events_tasks
  # end
end
