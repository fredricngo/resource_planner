class LocationsController < ApplicationController
  def index
    matching_locations = Location.all

    @list_of_locations = matching_locations.order({ :created_at => :desc })

    render({ :template => "location_templates/index" })
  end

  

  def show
    the_id = params.fetch("path_id")

    matching_locations = Location.where({ :id => the_id })

    @the_location = matching_locations.at(0)

    render({ :template => "location_templates/show" })
  end

  def create
    the_location = Location.new
    the_location.location_name = params.fetch("query_location_name")
    the_location.location_distance = params.fetch("query_location_distance")

    if the_location.valid?
      the_location.save
      redirect_to("/locations", { :notice => "Location created successfully." })
    else
      redirect_to("/locations", { :alert => the_location.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_location = Location.where({ :id => the_id }).at(0)

    the_location.location_name = params.fetch("query_location_name")
    the_location.location_distance = params.fetch("query_location_distance")

    if the_location.valid?
      the_location.save
      redirect_to("/locations/#{the_location.id}", { :notice => "Location updated successfully." } )
    else
      redirect_to("/locations/#{the_location.id}", { :alert => the_location.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_location = Location.where({ :id => the_id }).at(0)

    the_location.destroy

    redirect_to("/locations", { :notice => "Location deleted successfully." } )
  end
end
