# == Schema Information
#
# Table name: events
#
#  id                 :bigint           not null, primary key
#  application_fee    :float
#  created_by         :integer
#  event_date         :datetime
#  event_duration     :integer
#  event_location     :integer
#  event_name         :string
#  hourly_labor       :float
#  mile_reimbursement :float
#  participation_fee  :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Event < ApplicationRecord
  has_many  :onigiri_events, class_name: "OnigiriEvent", foreign_key: "event_id", dependent: :destroy
  belongs_to :event_site, required: true, class_name: "Location", foreign_key: "event_location"
  belongs_to :creator, required: true, class_name: "User", foreign_key: "created_by"
  has_many :onigiris, through: :onigiri_events, source: :onigiri

  def total_labor_cost
    hourly_labor * (event_duration + 3)
  end

  def total_reimbursement
    mile_reimbursement * event_site.location_distance
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
