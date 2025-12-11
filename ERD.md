# Onigiri Kororin Event Planning App - Entity Relationship Diagram

## Entities

### Events
| Column | Type | Source |
|--------|------|--------|
| id | int | primary key, auto-generated |
| event_name | string | user input |
| location_id | int | foreign key → locations.id |
| event_date | datetime | user input |
| application_fee | decimal | user input |
| participation_fee | decimal | user input |
| event_duration | int | user input (hours) |
| hourly_labor | decimal | user input (default: $19) |
| mile_reimbursement | decimal | user input (default: $0.45) |
| user_id | int | foreign key → users.id |

### Locations
| Column | Type | Source |
|--------|------|--------|
| id | int | primary key, auto-generated |
| location_name | string | user input |
| location_distance | decimal | user input (miles from kitchen) |

### Onigiris
| Column | Type | Source |
|--------|------|--------|
| id | int | primary key, auto-generated |
| flavor | string | user input |
| unit_cost | decimal | user input (default: $1.10) |
| unit_profit | decimal | user input (default: $5.90) |

*Note: unit_cost and unit_profit here serve as default values. Actual prices for each event are stored in the join table.*

### OnigiriEvents (Join Table)
| Column | Type | Source |
|--------|------|--------|
| id | int | primary key, auto-generated |
| onigiri_id | int | foreign key → onigiris.id |
| event_id | int | foreign key → events.id |
| unit_cost | decimal | user input (pre-filled from onigiri default) |
| unit_profit | decimal | user input (pre-filled from onigiri default) |
| quantity_brought | int | user input |
| quantity_sold | int | user input (optional for planning mode) |

*Constraint: unique combination of (onigiri_id, event_id)*

### Users
| Column | Type | Source |
|--------|------|--------|
| id | int | primary key, auto-generated |
| username | string | user input |
| email | string | user input |

---

## Relationships

```
Users ──< Events
  - A user (1) creates many events (N)
  - Event belongs_to User

Locations ──< Events
  - A location (1) hosts many events (N)
  - Event belongs_to Location

Events >──< Onigiris (through OnigiriEvents)
  - An event (N) sells many onigiris (M)
  - Event has_many OnigiriEvents
  - Event has_many Onigiris, through: OnigiriEvents
  - Onigiri has_many OnigiriEvents
  - Onigiri has_many Events, through: OnigiriEvents
```

---

## Rails Associations

```ruby
# app/models/user.rb
class User < ApplicationRecord
  has_many :events
end

# app/models/location.rb
class Location < ApplicationRecord
  has_many :events
end

# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :onigiri_events
  has_many :onigiris, through: :onigiri_events
end

# app/models/onigiri.rb
class Onigiri < ApplicationRecord
  has_many :onigiri_events
  has_many :events, through: :onigiri_events
end

# app/models/onigiri_event.rb
class OnigiriEvent < ApplicationRecord
  belongs_to :onigiri
  belongs_to :event
end
```
