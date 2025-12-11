# Onigiri Kororin Event Planning App - Formulas & Calculations

## Input Values (Stored in Database)

### From Event
- `application_fee`
- `participation_fee`
- `hourly_labor` (default: $19/hour)
- `event_duration` (hours)
- `mile_reimbursement` (default: $0.45/mile)

### From Location (via Event)
- `location.location_distance` (miles from kitchen)

### From OnigiriEvents (per flavor, per event)
- `quantity_brought`
- `quantity_sold`
- `unit_cost` (default: $1.10)
- `unit_profit` (default: $5.90)

---

## Calculated Values (Computed on Render)

### Labor Cost
```
total_labor_cost = hourly_labor × (event_duration + 3)
```
*Note: +3 accounts for 2 hours setup before and 1 hour cleanup after the event*

### Travel Reimbursement
```
total_reimbursement = mile_reimbursement × location.location_distance
```

### Onigiri Totals
```
total_onigiri_brought = Σ (quantity_brought) for all flavors at event

total_onigiri_cost = Σ (quantity_brought × unit_cost) for all flavors at event

total_revenue = Σ (quantity_sold × unit_profit) for all flavors at event
```

### Total Cost
```
total_cost = application_fee 
           + participation_fee 
           + total_labor_cost 
           + total_reimbursement 
           + total_onigiri_cost
```

### Total Profit
```
total_profit = total_revenue - total_cost
```

---

## Break-Even Calculation

### The Core Question
> "If we bring X onigiri, how many do we need to sell to break even?"

### Formula
```
qty_to_sell_for_breakeven = total_cost / unit_profit
```

*Note: For v0, assumes flat unit_profit across all flavors. If flavors have different prices, use weighted average or calculate per-flavor.*

### Example
```
Application fee:      $50
Participation fee:    $100
Labor (7 hrs × $19):  $133
Travel (20 mi × $0.45): $9
Onigiri cost (100 × $1.10): $110
─────────────────────────
Total cost:           $402

Break-even qty = $402 / $5.90 = 68.1 → need to sell 69 onigiri
```

---

## App Usage Modes

### 1. Planning Mode (Before Event)
**Use case:** "We're thinking of bringing 100 onigiri. How many do we need to sell to break even?"

- **Inputs:** All event details + quantity_brought
- **Output:** qty_to_sell_for_breakeven
- **quantity_sold:** Left blank or set to 0

### 2. Evaluation Mode (After Event)
**Use case:** "We brought 100 and sold 85. Did we profit?"

- **Inputs:** All event details + quantity_brought + quantity_sold
- **Output:** total_profit (positive = profit, negative = loss)

---

## Rails Implementation Notes

These calculations should be methods on the Event model, not stored columns:

```ruby
# app/models/event.rb
class Event < ApplicationRecord
  def total_labor_cost
    hourly_labor * (event_duration + 3)
  end

  def total_reimbursement
    mile_reimbursement * location.location_distance
  end

  def total_onigiri_brought
    onigiri_events.sum(:quantity_brought)
  end

  def total_onigiri_cost
    onigiri_events.sum("quantity_brought * unit_cost")
  end

  def total_revenue
    onigiri_events.sum("quantity_sold * unit_profit")
  end

  def total_cost
    application_fee + participation_fee + total_labor_cost + total_reimbursement + total_onigiri_cost
  end

  def total_profit
    total_revenue - total_cost
  end

  def breakeven_quantity
    return 0 if average_unit_profit.zero?
    (total_cost / average_unit_profit).ceil
  end

  private

  def average_unit_profit
    # For v0: assumes flat pricing, just grab first unit_profit
    # Future: calculate weighted average if prices vary
    onigiri_events.first&.unit_profit || 0
  end
end
```
