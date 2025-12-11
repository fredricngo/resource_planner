class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    matching_events = Event.all

    @list_of_events = matching_events.order({ :created_at => :desc })

    render({ :template => "event_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_events = Event.where({ :id => the_id })

    @the_event = matching_events.at(0)

    render({ :template => "event_templates/show" })
  end

  def create
    the_event = Event.new
    the_event.event_name = params.fetch("query_event_name")
    the_event.event_location = params.fetch("query_event_location")  
    the_event.event_date = params.fetch("query_event_date")
    the_event.application_fee = params.fetch("query_application_fee")
    the_event.participation_fee = params.fetch("query_participation_fee")
    the_event.event_duration = params.fetch("query_event_duration")
    the_event.hourly_labor = params.fetch("query_hourly_labor")
    the_event.mile_reimbursement = params.fetch("query_mile_reimbursement")
    the_event.created_by = current_user.id 
    if the_event.valid?
      the_event.save
      redirect_to("/events", { :notice => "Event created successfully." })
    else
      redirect_to("/events", { :alert => the_event.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_event = Event.where({ :id => the_id }).at(0)

    the_event.event_name = params.fetch("query_event_name")
    the_event.event_location = params.fetch("query_event_location")
    the_event.event_date = params.fetch("query_event_date")
    the_event.application_fee = params.fetch("query_application_fee")
    the_event.participation_fee = params.fetch("query_participation_fee")
    the_event.event_duration = params.fetch("query_event_duration")
    the_event.hourly_labor = params.fetch("query_hourly_labor")
    the_event.mile_reimbursement = params.fetch("query_mile_reimbursement")
    the_event.created_by = params.fetch("query_created_by")

    if the_event.valid?
      the_event.save
      redirect_to("/events/#{the_event.id}", { :notice => "Event updated successfully." } )
    else
      redirect_to("/events/#{the_event.id}", { :alert => the_event.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_event = Event.where({ :id => the_id }).at(0)

    the_event.destroy

    redirect_to("/events", { :notice => "Event deleted successfully." } )
  end
end
