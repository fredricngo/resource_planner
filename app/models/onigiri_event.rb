# == Schema Information
#
# Table name: onigiri_events
#
#  id               :bigint           not null, primary key
#  quantity_brought :integer
#  quantity_sold    :integer
#  unit_cost        :float
#  unit_profit      :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  event_id         :integer
#  onigiri_id       :integer
#
class OnigiriEvent < ApplicationRecord
  belongs_to :event, required: true, class_name: "Event", foreign_key: "event_id"
  belongs_to :onigiri, required: true, class_name: "Onigiri", foreign_key: "onigiri_id"
end
