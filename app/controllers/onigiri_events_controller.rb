class OnigiriEventsController < ApplicationController
  def index
    matching_onigiri_events = OnigiriEvent.all

    @list_of_onigiri_events = matching_onigiri_events.order({ :created_at => :desc })

    render({ :template => "onigiri_event_templates/index" })
  end

  def new
    @event = Event.where({ :id => params.fetch("event_id") }).at(0)
    @list_of_onigiris = Onigiri.all
    render({ :template => "onigiri_event_templates/new" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_onigiri_events = OnigiriEvent.where({ :id => the_id })

    @the_onigiri_event = matching_onigiri_events.at(0)

    render({ :template => "onigiri_event_templates/show" })
  end

  def create
    the_onigiri_event = OnigiriEvent.new
    the_onigiri_event.onigiri_id = params.fetch("query_onigiri_id")
    the_onigiri_event.event_id = params.fetch("query_event_id")
    the_onigiri_event.unit_cost = params.fetch("query_unit_cost")
    the_onigiri_event.unit_profit = params.fetch("query_unit_profit")
    the_onigiri_event.quantity_brought = params.fetch("query_quantity_brought")
    the_onigiri_event.quantity_sold = params.fetch("query_quantity_sold")
    if the_onigiri_event.valid?
      the_onigiri_event.save
      redirect_to("/events/#{the_onigiri_event.event_id}", { :notice => "Onigiri added successfully." })
    else
      redirect_to("/events/#{the_onigiri_event.event_id}", { :alert => the_onigiri_event.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_onigiri_event = OnigiriEvent.where({ :id => the_id }).at(0)

    the_onigiri_event.onigiri_id = params.fetch("query_onigiri_id")
    the_onigiri_event.event_id = params.fetch("query_event_id")
    the_onigiri_event.unit_cost = params.fetch("query_unit_cost")
    the_onigiri_event.unit_profit = params.fetch("query_unit_profit")
    the_onigiri_event.quantity_brought = params.fetch("query_quantity_brought")
    the_onigiri_event.quantity_sold = params.fetch("query_quantity_sold")

    if the_onigiri_event.valid?
      the_onigiri_event.save
      redirect_to("/onigiri_events/#{the_onigiri_event.id}", { :notice => "Onigiri event updated successfully." } )
    else
      redirect_to("/onigiri_events/#{the_onigiri_event.id}", { :alert => the_onigiri_event.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_onigiri_event = OnigiriEvent.where({ :id => the_id }).at(0)

    the_onigiri_event.destroy

    redirect_to("/onigiri_events", { :notice => "Onigiri event deleted successfully." } )
  end
end
