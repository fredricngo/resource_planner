Rails.application.routes.draw do
  # Routes for the Onigiri event resource:

  # CREATE
  post("/insert_onigiri_event", { :controller => "onigiri_events", :action => "create" })

  # READ
  get("/onigiri_events", { :controller => "onigiri_events", :action => "index" })

  get("/onigiri_events/new", { :controller => "onigiri_events", :action => "new" })

  get("/onigiri_events/:path_id", { :controller => "onigiri_events", :action => "show" })


  # UPDATE

  post("/modify_onigiri_event/:path_id", { :controller => "onigiri_events", :action => "update" })

  # DELETE
  get("/delete_onigiri_event/:path_id", { :controller => "onigiri_events", :action => "destroy" })

  #------------------------------

  # Routes for the Onigiri resource:

  # CREATE
  post("/insert_onigiri", { :controller => "onigiris", :action => "create" })

  # READ
  get("/onigiris", { :controller => "onigiris", :action => "index" })

  get("/onigiris/:path_id", { :controller => "onigiris", :action => "show" })

  # UPDATE

  post("/modify_onigiri/:path_id", { :controller => "onigiris", :action => "update" })

  # DELETE
  get("/delete_onigiri/:path_id", { :controller => "onigiris", :action => "destroy" })

  #------------------------------

  # Routes for the Location resource:

  # CREATE
  post("/insert_location", { :controller => "locations", :action => "create" })

  # READ
  get("/locations", { :controller => "locations", :action => "index" })

  get("/locations/:path_id", { :controller => "locations", :action => "show" })

  # UPDATE

  post("/modify_location/:path_id", { :controller => "locations", :action => "update" })

  # DELETE
  get("/delete_location/:path_id", { :controller => "locations", :action => "destroy" })

  #------------------------------

  # Routes for the Event resource:

  # CREATE
  post("/insert_event", { :controller => "events", :action => "create" })

  # READ
  get("/events", { :controller => "events", :action => "index" })

  get("/events/:path_id", { :controller => "events", :action => "show" })

  # UPDATE

  post("/modify_event/:path_id", { :controller => "events", :action => "update" })

  # DELETE
  get("/delete_event/:path_id", { :controller => "events", :action => "destroy" })

  #------------------------------

  devise_for :users
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end
