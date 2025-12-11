# Save this as lib/tasks/sample_data.rake
# Run with: rails sample_data

task sample_data: :environment do
  puts "Clearing existing data..."
  OnigiriEvent.destroy_all
  Event.destroy_all
  Onigiri.destroy_all
  Location.destroy_all
  User.destroy_all

  puts "Creating users..."
  user = User.create!(
    email: "dahlia@onigiri.com",
    password: "password",
  )

  puts "Creating locations..."
  loc1 = Location.create!(
    location_name: "Downtown Farmers Market",
    location_distance: 12
  )
  loc2 = Location.create!(
    location_name: "University Campus Fair",
    location_distance: 8
  )
  loc3 = Location.create!(
    location_name: "Chinatown Night Market",
    location_distance: 15
  )

  puts "Creating onigiri flavors..."
  salmon = Onigiri.create!(
    onigiri_flavor: "Salmon",
  )
  umeboshi = Onigiri.create!(
    onigiri_flavor: "Umeboshi",

  )
  tuna = Onigiri.create!(
    onigiri_flavor: "Tuna Mayo",

  )
  veggie = Onigiri.create!(
    onigiri_flavor: "Vegetable",

  )

  puts "Creating sample events..."
  event1 = Event.create!(
    event_name: "Saturday Farmers Market",
    event_site: loc1,
    creator: user,
    event_date: Date.today + 7,
    application_fee: 50,
    participation_fee: 100,
    event_duration: 4,
    hourly_labor: 19,
    mile_reimbursement: 0.45
  )

  event2 = Event.create!(
    event_name: "Campus Welcome Week",
    event_site: loc2,
    creator: user,
    event_date: Date.today + 14,
    application_fee: 0,
    participation_fee: 75,
    event_duration: 6,
    hourly_labor: 19,
    mile_reimbursement: 0.45
  )

  puts "Adding onigiri to events..."
  # Event 1 - planning stage (no sales yet)
  OnigiriEvent.create!(event: event1, onigiri: salmon, unit_cost: 1.10, unit_profit: 5.90, quantity_brought: 40, quantity_sold: 0)
  OnigiriEvent.create!(event: event1, onigiri: umeboshi, unit_cost: 1.10, unit_profit: 5.90, quantity_brought: 30, quantity_sold: 0)
  OnigiriEvent.create!(event: event1, onigiri: tuna, unit_cost: 1.10, unit_profit: 5.90, quantity_brought: 30, quantity_sold: 0)

  # Event 2 - completed event with sales
  OnigiriEvent.create!(event: event2, onigiri: salmon, unit_cost: 1.10, unit_profit: 5.90, quantity_brought: 50, quantity_sold: 45)
  OnigiriEvent.create!(event: event2, onigiri: veggie, unit_cost: 1.00, unit_profit: 5.50, quantity_brought: 25, quantity_sold: 20)

  puts "Done! Created:"
  puts "  - #{User.count} user"
  puts "  - #{Location.count} locations"
  puts "  - #{Onigiri.count} onigiri flavors"
  puts "  - #{Event.count} events"
  puts "  - #{OnigiriEvent.count} onigiri-event entries"
  puts ""
  puts "Login with: dahlia@onigiri.com / password"
end
