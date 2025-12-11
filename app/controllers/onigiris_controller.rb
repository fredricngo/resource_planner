class OnigirisController < ApplicationController
  def index
    matching_onigiris = Onigiri.all

    @list_of_onigiris = matching_onigiris.order({ :created_at => :desc })

    render({ :template => "onigiri_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_onigiris = Onigiri.where({ :id => the_id })

    @the_onigiri = matching_onigiris.at(0)

    render({ :template => "onigiri_templates/show" })
  end

  def create
    the_onigiri = Onigiri.new
    the_onigiri.onigiri_flavor = params.fetch("query_onigiri_flavor")

    if the_onigiri.valid?
      the_onigiri.save
      redirect_to("/onigiris", { :notice => "Onigiri created successfully." })
    else
      redirect_to("/onigiris", { :alert => the_onigiri.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_onigiri = Onigiri.where({ :id => the_id }).at(0)

    the_onigiri.onigiri_flavor = params.fetch("query_onigiri_flavor")

    if the_onigiri.valid?
      the_onigiri.save
      redirect_to("/onigiris/#{the_onigiri.id}", { :notice => "Onigiri updated successfully." } )
    else
      redirect_to("/onigiris/#{the_onigiri.id}", { :alert => the_onigiri.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_onigiri = Onigiri.where({ :id => the_id }).at(0)

    the_onigiri.destroy

    redirect_to("/onigiris", { :notice => "Onigiri deleted successfully." } )
  end
end
